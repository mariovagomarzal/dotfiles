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

  # Facts from a system configuration; Homebrew only exists in nix-darwin.
  systemFacts = cfg:
    builtins.concatLists [
      (itemsOf "packages" cfg.options.environment.systemPackages)
      (itemsOf "fonts" cfg.options.fonts.packages)
      (enabledIn "programs" cfg.options.programs)
      (enabledIn "services" cfg.options.services)
    ]
    ++ lib.optionals (cfg.options ? homebrew) (builtins.concatLists [
      (itemsOf "brews" cfg.options.homebrew.brews)
      (itemsOf "casks" cfg.options.homebrew.casks)
      (itemsOf "apps" cfg.options.homebrew.masApps)
    ]);

  homeFacts = hm:
    builtins.concatLists [
      (itemsOf "packages" hm.options.home.packages)
      (enabledIn "programs" hm.options.programs)
      (enabledIn "services" hm.options.services)
    ];

  # A system's users are read from the system configuration, on their host's platform. Their options come without
  # home-manager's assertion checks, which would build files during evaluation and fail on another platform.
  userOf = cfg: user: cfg.options.home-manager.users.valueMeta.attrs.${user}.configuration;

  # Homes of machines managed by home-manager alone, which can be any platform, are evaluated for the system building
  # the site.
  homeOf = user: host: flake.legacyPackages.${system}.homeConfigurations."${user}@${host}";

  # Machines with a system configuration, and the file that defines each kind.
  systemHosts =
    lib.mapAttrsToList (name: cfg: {
      inherit name cfg;
      manager = "nix-darwin";
      file = "darwin-configuration.nix";
    })
    flake.darwinConfigurations
    ++ lib.mapAttrsToList (name: cfg: {
      inherit name cfg;
      manager = "NixOS";
      file = "configuration.nix";
    })
    flake.nixosConfigurations;

  # Machines managed by home-manager alone: homes whose host has no system configuration.
  systemNames = map (h: h.name) systemHosts;
  homeOnly = builtins.groupBy (h: h.host) (builtins.filter (h: !(builtins.elem h.host systemNames)) (map (key: let
    parts = builtins.match "(.*)@(.*)" key;
  in {
    user = builtins.elemAt parts 0;
    host = builtins.elemAt parts 1;
  }) (builtins.attrNames (flake.legacyPackages.${system}.homeConfigurations or {}))));

  userEntry = host: user: {
    name = user;
    modules = importsOf (hostDir host + "/users/${user}.nix");
  };

  hosts =
    map (h: {
      inherit (h) name manager;
      platform = h.cfg.pkgs.stdenv.hostPlatform.system;
      modules = importsOf (hostDir h.name + "/${h.file}");
      users = map (userEntry h.name) (builtins.attrNames (h.cfg.config.home-manager.users or {}));
    })
    systemHosts
    ++ lib.mapAttrsToList (host: homes: {
      name = host;
      manager = "home-manager";
      platform = null;
      modules = [];
      users = map (h: userEntry host h.user) homes;
    })
    homeOnly;

  # Facts from every host, merged per module and class.
  allFacts =
    lib.concatMap (h:
      systemFacts h.cfg
      ++ lib.concatMap (user: homeFacts (userOf h.cfg user))
      (builtins.attrNames (h.cfg.config.home-manager.users or {})))
    systemHosts
    ++ lib.concatLists (lib.mapAttrsToList (host: homes:
      lib.concatMap (h: homeFacts (homeOf h.user host)) homes)
    homeOnly);

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
  }
