{pkgs, ...}: {
  programs.lua = {
    enable = true;
    package = pkgs.lua5_4;

    extraPackages = [
      (ps:
        with ps; [
          luarocks
        ])
    ];
  };
}
