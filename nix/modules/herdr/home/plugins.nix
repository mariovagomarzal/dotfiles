# workaround: home-manager's `programs.herdr` has no option for plugins, so
# this one, with its activation, is declared here. Remove when it has one
# (https://github.com/nix-community/home-manager/blob/master/modules/programs/herdr.nix).
#
# Herdr keeps its plugins in `plugins.json`, a registry it writes itself, so the
# file cannot be generated. Instead, each plugin is a package holding the plugin
# directory, linked with `herdr plugin link` on activation; plugins linked from
# the Nix store that are no longer listed are unlinked, and those installed by
# hand are left alone.
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.herdr;
  herdr = lib.getExe cfg.package;
  jq = lib.getExe pkgs.jq;
  registry = "${config.xdg.configHome}/herdr/plugins.json";
in {
  options.programs.herdr.plugins = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [];
    example = lib.literalExpression "[perSystem.self.herdr-nvim]";
    description = ''
      Plugins linked into Herdr on activation, each a package whose output is
      the plugin directory, with {file}`herdr-plugin.toml` at its root.
    '';
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.plugins == [] || cfg.package != null;
        message = "programs.herdr.plugins needs programs.herdr.package to link the plugins.";
      }
    ];

    home.activation.herdrPlugins = lib.mkIf (cfg.package != null) (
      lib.hm.dag.entryAfter ["linkGeneration"] ''
        export XDG_CONFIG_HOME=${lib.escapeShellArg config.xdg.configHome}
        herdrRegistry=${lib.escapeShellArg registry}
        herdrPlugins=(${lib.escapeShellArgs (map toString cfg.plugins)})

        # `uninstall` also works without a running server, unlike `unlink`.
        # It keeps the plugin's own config and state directories.
        if [[ -f $herdrRegistry ]]; then
          while IFS=$'\t' read -r id root; do
            if [[ " ''${herdrPlugins[*]} " != *" $root "* ]]; then
              run --quiet ${herdr} plugin uninstall "$id"
            fi
          done < <(${jq} -r --arg store ${lib.escapeShellArg "${builtins.storeDir}/"} \
            '.[] | select(.plugin_root | startswith($store)) | [.plugin_id, .plugin_root] | @tsv' \
            "$herdrRegistry")
        fi

        for root in "''${herdrPlugins[@]}"; do
          if [[ ! -f $herdrRegistry ]] \
            || ! ${jq} -e --arg root "$root" 'any(.[]; .plugin_root == $root)' "$herdrRegistry" >/dev/null; then
            run --quiet ${herdr} plugin link "$root"
          fi
        done
      ''
    );
  };
}
