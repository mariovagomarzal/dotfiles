{pkgs, ...}: {
  home.packages = [
    (pkgs.lua5_4.withPackages (ps: [ps.luarocks]))
  ];
}
