###########################
# Packages shared module. #
###########################
{
  pkgs,
  config,
  ...
}: let
  # The 'fish' package used in the configuration.
  fish = config.programs.fish.package;
in {
  # Shell configuration.
  programs.fish.enable = true;
  environment.shells = [fish];
  environment.variables.SHELL = "/run/current-system/sw${fish.shellPath}";
  users.knownUsers = [config.system.primaryUser];
  users.users.${config.system.primaryUser}.shell = fish;

  # Other packages that should be available system-wide.
  environment.systemPackages = with pkgs; [
    # Core tools.
    git
    gnupg
    just

    # Text editors.
    vim

    # Programming languages (or related).
    python312

    # Miscellaneous.
    aria2
  ];

  # Fonts.
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    newcomputermodern
  ];

  # Environment variables (related to the packages managed here).
  environment.variables = {
    EDITOR = "vim";
  };
}
