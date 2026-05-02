#####################################
# Regex language support submodule. #
#####################################
{config, ...}: {
  programs.nixvim = {
    # Treesitter grammar.
    plugins.treesitter.grammarPackages = [
      config.programs.nixvim.plugins.treesitter.package.builtGrammars.regex
    ];
  };
}
