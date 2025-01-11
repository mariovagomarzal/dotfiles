####################################
# Git configuration for this user. #
####################################
{...}: {
  programs.git = {
    # Extra configuration.
    extraConfig = {
      # Key related configuration.
      gpg.format = "ssh";
      credential.helper = "osxkeychain";
      user.signingkey = "~/.ssh/id_ed25519";
    };
  };
}
