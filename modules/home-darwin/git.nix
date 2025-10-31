###############################
# Git home module for Darwin. #
###############################
{...}: {
  # Set the macOS 'osxkeychain' as credential helper.
  programs.git.settings.credential.helper = "osxkeychain";
}
