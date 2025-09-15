####################################
# Development shell configuration. #
####################################
{
  inputs,
  pkgs,
  ...
}: let
  system = pkgs.system;
  git-hooks-check = inputs.self.checks.${system}.git-hooks;
in
  pkgs.devshell.mkShell {
    devshell = {
      name = "dev";
      motd = ''
        {2}{bold}[i] Development shell for Mario's dotfiles repository.{reset}
        $(type -p menu &> /dev/null && menu)
      '';
      startup."install-git-hooks".text = git-hooks-check.shellHook;
      packages = git-hooks-check.enabledPackages;
    };

    commands = [
      {
        package = pkgs.git;
        help = "Use Git for version control.";
      }
      {
        package = pkgs.just;
        help = "Type 'just' to see the available tasks.";
      }
    ];
  }
