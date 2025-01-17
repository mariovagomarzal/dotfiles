########################################
# Entry point for my Nixpkgs overlays. #
########################################
{...}: {
  # Lua related overlays.
  lua = import ./lua {};
}
