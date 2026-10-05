{config, ...}: let
  fish = config.programs.fish.package;
in {
  programs.fish.enable = true;
  environment.shells = [fish];
  environment.variables.SHELL = "/run/current-system/sw${fish.shellPath}";
  users.knownUsers = [config.system.primaryUser];
  users.users.${config.system.primaryUser}.shell = fish;
}
