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
  # Enable the fish shell and add it to the list of available shells. Also, set
  # the default shell to fish by setting the `SHELL` environment variable.
  programs.fish.enable = true;
  environment.shells = [fish];
  environment.variables.SHELL = "/run/current-system/sw${fish.shellPath}";

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
