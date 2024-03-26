#####################################
# Alicritty terminal configuration. #
#####################################
{inputs, ...}: {
  programs.alacrity = {
    enable = true;

    # Alacritty configuration content.
    settings = {
      import = [
        inputs.alacritty-theme.themes."ayu_dark.toml"
      ];
    };
  };
}
