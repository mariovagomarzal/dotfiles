{pkgs, ...}: let
  shellAliases = {
    cat = "bat";
    man = "batman";
  };
in {
  programs.bat = {
    enable = true;

    extraPackages = with pkgs.bat-extras; [
      batman
    ];
  };

  programs.bash.shellAliases = shellAliases;
  programs.zsh.shellAliases = shellAliases;
  programs.fish.shellAliases = shellAliases;
}
