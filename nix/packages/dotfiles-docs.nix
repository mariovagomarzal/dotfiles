/**
Builds and serves the documentation site: `nix run .#dotfiles-docs -- build`,
or `dev` and `preview`.

It runs in the working tree instead of a sandbox, because the site needs git
history, which is not part of a flake's source. Facts that require evaluation,
such as which hosts import each module and what it installs, are computed here
and passed to the site as JSON.
*/
{
  flake,
  pkgs,
  system,
  ...
}: let
  inherit (pkgs) lib;

  # Evaluation reports files as store paths; keep what follows `nix/modules/`.
  locate = file: let
    m = builtins.match ".*/nix/+modules/([^/]+)/([^/]+)(/.*)?" (toString file);
  in
    if m == null
    then null
    else {
      module = builtins.elemAt m 0;
      class = lib.removeSuffix ".nix" (builtins.elemAt m 1);
    };

  id = l: "${l.module}/${l.class}";

  # Names only: a string with context would make the JSON depend on every package.
  nameOf = v:
    builtins.unsafeDiscardStringContext (
      if builtins.isString v
      then v
      else
        v.pname or (
          if v ? name
          then lib.getName v
          else "?"
        )
    );

  # Discharge the wrappers a definition may carry, such as mkDefault or mkIf.
  unwrap = v:
    if builtins.isAttrs v && (v._type or null) == "override"
    then unwrap v.content
    else if builtins.isAttrs v && (v._type or null) == "if"
    then
      if v.condition
      then unwrap v.content
      else null
    else v;

  # Definitions of one option, grouped by the module file that wrote them.
  definedBy = opt:
    lib.concatMap (
      d: let
        l = locate d.file;
      in
        lib.optional (l != null) {
          id = id l;
          value = unwrap d.value;
        }
    )
    (opt.definitionsWithLocations or []);

  # Which modules list which items in a list or attrset option.
  itemsOf = kind: opt:
    map (d: {
      inherit (d) id;
      ${kind} =
        if builtins.isList d.value
        then map nameOf d.value
        else if builtins.isAttrs d.value
        then builtins.attrNames d.value
        else [];
    }) (definedBy opt);

  # Which modules switch on which programs or services.
  enabledIn = kind: opts:
    lib.concatLists (lib.mapAttrsToList (
        name: opt:
          lib.optionals (builtins.isAttrs opt && opt ? enable && lib.isOption opt.enable)
          (map (d: {
            inherit (d) id;
            ${kind} = [name];
          }) (builtins.filter (d: d.value == true) (definedBy opt.enable)))
      )
      opts);

  hostDir = name: flake + "/nix/hosts/${name}";

  # The modules a host or user file imports, read from the file itself.
  importsOf = file: let
    imported = (import file {inherit flake;}).imports or [];
  in
    builtins.filter (x: x != null) (map (m: let
      l = locate (m._file or m);
    in
      if l == null
      then null
      else id l)
    imported);

  facts = cfg: hm:
    builtins.concatLists [
      (itemsOf "packages" cfg.options.environment.systemPackages)
      (itemsOf "fonts" cfg.options.fonts.packages)
      (itemsOf "brews" cfg.options.homebrew.brews)
      (itemsOf "casks" cfg.options.homebrew.casks)
      (itemsOf "apps" cfg.options.homebrew.masApps)
      (enabledIn "programs" cfg.options.programs)
      (enabledIn "services" cfg.options.services)
      (itemsOf "packages" hm.options.home.packages)
      (enabledIn "programs" hm.options.programs)
      (enabledIn "services" hm.options.services)
    ];

  hosts =
    lib.mapAttrsToList (name: cfg: let
      users = builtins.attrNames cfg.config.home-manager.users;
    in {
      inherit name;
      platform = cfg.pkgs.stdenv.hostPlatform.system;
      modules = importsOf (hostDir name + "/darwin-configuration.nix");
      users =
        map (user: {
          name = user;
          modules = importsOf (hostDir name + "/users/${user}.nix");
        })
        users;
    })
    flake.darwinConfigurations;

  # Facts from every host, merged per module and class.
  allFacts = lib.concatLists (lib.mapAttrsToList (name: cfg:
    lib.concatMap (user:
      facts cfg flake.legacyPackages.${system}.homeConfigurations."${user}@${name}")
    (builtins.attrNames cfg.config.home-manager.users))
  flake.darwinConfigurations);

  modules = builtins.foldl' (acc: f: let
    entry = acc.${f.id} or {};
    fields = builtins.removeAttrs f ["id"];
  in
    acc
    // {
      ${f.id} = entry // lib.mapAttrs (k: v: lib.unique ((entry.${k} or []) ++ v)) fields;
    }) {}
  allFacts;
  data = pkgs.writeText "dotfiles-docs.json" (builtins.toJSON {inherit hosts modules;});
in
  pkgs.writeShellApplication {
    name = "dotfiles-docs";
    runtimeInputs = with pkgs; [git nodejs_24 pnpm];
    text = ''
      cd "$(git rev-parse --show-toplevel)/docs"
      export DOCS_DATA=${data}
      pnpm install --frozen-lockfile --silent
      exec pnpm "''${1:-build}" "''${@:2}"
    '';
    meta.platforms = lib.platforms.darwin;
  }
