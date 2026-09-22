#####################
# Core home module. #
#####################
{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.nixvim.homeModules.nixvim
  ];
}
