############################################
# Custom Home-Manager modules entry point. #
############################################
{...}: {
  imports = [
    # Module for Lua.
    ./lua.nix

    # Module for Yabai.
    ./yabai.nix

    # Module for Skhd.
    ./skhd.nix
  ];
}
