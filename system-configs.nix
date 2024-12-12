######################################
# System configurations definitions. #
######################################
inputs @ {...}: let
  # Auxiliary function for importing configuration files.
  importConfig = pathToConfig: (
    import pathToConfig {inherit inputs;}
  );
in {
  darwinConfigurations =
    # Mario's MacBook Pro configuration.
    importConfig ./darwin-configurations/marios-macbook-pro.nix;
}
