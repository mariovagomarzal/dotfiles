################################################################################
# Mario Vago Marzal's (mariovagomarzal) home configuration for aarch64-darwin. #
################################################################################
{pkgs, ...}: {
  home.stateVersion = "25.05";

  # No-configuration packages.
  home.packages = with pkgs; [
  ];

  # Minimal configuration-dependent programs and/or services.
  programs = {};
  services = {};

  imports = [
    ./ssh.nix
    ./git.nix
    ./firefox.nix
    ./yabai
    ./skhd
    ./jankyborders.nix
  ];
}
