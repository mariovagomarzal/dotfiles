######################
# Bat configuration. #
######################
{pkgs, ...}: let
  # Extra shell aliases to add.
  shellAliases = {
    cat = "bat";
    man = "batman";
  };
in {
  programs.bat = {
    enable = true;

    # Extra packages for Bat.
    extraPackages = with pkgs.bat-extras; [
      batman
    ];
  };

  # Add shell aliases for Bat.
  programs.bash.shellAliases = shellAliases;
  programs.zsh.shellAliases = shellAliases;
  programs.fish.shellAliases = shellAliases;
}
