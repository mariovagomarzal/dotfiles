############################################
# Custom Home-Manager modules entry point. #
############################################
{...}: {
  imports = [
    # Module for Lua.
    ./lua.nix
  ];
}
