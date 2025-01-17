###########################
# SbarLua module overlay. #
###########################
{...}: final: prev: {
  lua = prev.lua.override {
    packageOverrides = luafinal: _: {
      sbarlua = luafinal.buildLuarocksPackage {
        pname = "sbarlua";
        version = "dev-1";
        src = final.fetchFromGitHub {
          owner = "mariovagomarzal";
          repo = "SbarLua";
          rev = "1dbdda8e0048a1d5253959dbb03f6d8ad428977d";
          sha256 = "sha256-TC/tAmpBDZikCrRkVOcOn5b4kckVs/IUeGxyh8cRYS8=";
        };
      };
    };
  };

  luaPackages = final.lua.pkgs;
}
