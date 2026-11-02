/**
herdr-nvim, a herdr plugin that keeps a Neovim sidebar in each tab, with a picker
for the files the agent touched and annotations sent back to it.

The output is the plugin directory itself, ready for `herdr plugin link`: the
manifest, the binary its commands run and the Lua that the plugin loads into
Neovim. The binary is built here instead of fetched by the plugin's build step.
*/
{pkgs, ...}:
# workaround: herdr plugins are not packaged anywhere, so this one is packaged
# here. Remove when nixpkgs or a NUR repository has it
# (https://github.com/ChmaraX/herdr-nvim).
pkgs.rustPlatform.buildRustPackage (finalAttrs: {
  pname = "herdr-nvim";
  version = "1.2.2";

  src = pkgs.fetchFromGitHub {
    owner = "ChmaraX";
    repo = "herdr-nvim";
    tag = "v${finalAttrs.version}";
    hash = "sha256-XPa9UEd6NuSOhtPnd5jEuz6XBIEZwhE7Rkz8a1++iRE=";
  };

  cargoHash = "sha256-4NvwuymitGOvPwhcpH4FJm0dwJKgKxz6yjAeFSTwNZE=";

  doCheck = false;

  # Neovim reads the help from `doc/` at the plugin's root.
  forceShare = ["man" "info"];

  postInstall = ''
    cp -r herdr-plugin.toml lua plugin doc LICENSE $out/
  '';

  meta = {
    description = "Neovim sidebar for herdr, with agent annotations";
    homepage = "https://github.com/ChmaraX/herdr-nvim";
    license = pkgs.lib.licenses.mit;
    mainProgram = "herdr-nvim";
    platforms = pkgs.lib.platforms.unix;
  };
})
