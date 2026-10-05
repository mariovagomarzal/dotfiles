/**
Lua 5.4 with LuaRocks.
*/
{pkgs, ...}: {
  home.packages = [
    (pkgs.lua5_4.withPackages (ps: [ps.luarocks]))
  ];
}
