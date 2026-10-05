{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    lsp.servers.bashls.enable = true;

    plugins.conform-nvim.settings = {
      formatters.shfmt.command = lib.getExe pkgs.shfmt;
      formatters_by_ft = {
        sh = ["shfmt"];
        bash = ["shfmt"];
      };
    };

    plugins.treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.bash
    ];
  };
}
