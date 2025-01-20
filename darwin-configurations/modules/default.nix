##########################################
# Custom nix-darwin modules entry point. #
##########################################
{...}: {
  imports = [
    # Yabai scripting addition module.
    ./yabai-sa.nix
  ];
}
