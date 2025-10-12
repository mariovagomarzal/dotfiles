#####################
# Git-hooks checks. #
#####################
{
  inputs,
  system,
  ...
}:
inputs.git-hooks-nix.lib.${system}.run {
  src = ./..;

  hooks = {
    # Enable the Alejandra git hook.
    alejandra.enable = true;

    # Enable the markdownlint git hook.
    markdownlint = {
      enable = true;
      settings.configuration = {
        # Allow to exceed the maximum line length.
        "MD013" = false;

        # Allow multiple headers with the same content.
        "MD024" = false;

        # Allow HTML in markdown files.
        "MD033" = false;

        # Allow the first line not to be a header.
        "MD041" = false;
      };
      excludes = ["CHANGELOG.md"];
    };

    # Enable the Gitlint git hook.
    gitlint.enable = true;
  };
}
