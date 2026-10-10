{flake, ...}: {
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking = {
    hostName = "Marios-MBP";
    computerName = "Mario's MacBook Pro";
  };

  system.defaults.smb = {
    NetBIOSName = "Marios-MBP";
    ServerDescription = "Marios-MBP";
  };

  users.users = {
    "mariovagomarzal" = {
      uid = 501;
      home = "/Users/mariovagomarzal";
      description = "Mario Vago Marzal";
    };
  };

  system.primaryUser = "mariovagomarzal";

  imports = with flake.modules; [
    homebrew.darwin
    alacritty.darwin
    calibre.darwin
    firefox.darwin
    obsidian.darwin
    macos.darwin
    mpv.darwin
    home-manager.darwin
    nix-settings.darwin
    fish.darwin
    keepassxc.darwin
    sops.darwin
    vesktop.darwin
    packages.darwin
  ];
}
