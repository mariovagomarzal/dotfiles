/**
The `dotfiles` command, with its configuration and shell integration, under
the shorter name `dt` too.

The settings are written to `$XDG_CONFIG_HOME/dotfiles/config.toml`. The shell
integration is what makes `dotfiles cd` change the shell's directory.
*/
{
  config,
  lib,
  pkgs,
  perSystem,
  ...
}: let
  cfg = config.programs.dotfiles;
  toml = pkgs.formats.toml {};
  integration = shell: "${lib.getExe cfg.package} shell ${shell}${lib.optionalString (cfg.alias != null) " --alias ${cfg.alias}"}";
in {
  options.programs.dotfiles = {
    enable = lib.mkEnableOption "the dotfiles command";

    package = lib.mkOption {
      type = lib.types.package;
      default = perSystem.self.dotfiles;
      defaultText = lib.literalExpression "perSystem.self.dotfiles";
      description = "The dotfiles command, built from this repository.";
    };

    settings = lib.mkOption {
      inherit (toml) type;
      default = {};
      example = {
        path = "~/Projects/mariovagomarzal/dotfiles";
        agent = "codex";
      };
      description = "Configuration written to `$XDG_CONFIG_HOME/dotfiles/config.toml`.";
    };

    alias = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "dt";
      description = "A shorter name for the command, with the same subcommands and completions.";
    };
  };

  config = lib.mkMerge [
    {
      programs.dotfiles = {
        enable = true;
        alias = "dt";
      };
    }

    (lib.mkIf cfg.enable {
      home.packages = [cfg.package];

      xdg.configFile."dotfiles/config.toml" = lib.mkIf (cfg.settings != {}) {
        source = toml.generate "dotfiles-config.toml" cfg.settings;
      };

      programs.fish.interactiveShellInit = "${integration "fish"} | source";
      programs.bash.initExtra = ''eval "$(${integration "bash"})"'';
      programs.zsh.initContent = ''eval "$(${integration "zsh"})"'';
    })
  ];
}
