########################################
# Git home module for mariovagomarzal. #
########################################
{...}: {
  programs.git = {
    # User email.
    userEmail = "mariovagomarzal@gmail.com";

    # Extra configuration.
    extraConfig = {
      # GitHub related configuration.
      github.user = "mariovagomarzal";

      # Key related configuration.
      gpg.format = "ssh";
      credential.helper = "osxkeychain";
      user.signingkey = "~/.ssh/id_ed25519";
    };
  };
}
