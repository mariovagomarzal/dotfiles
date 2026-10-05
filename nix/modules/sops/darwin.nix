/**
sops-nix, which decrypts the secrets kept encrypted in this repository when
the configuration is activated, using this machine's age key.

The key is readable only by root, so nothing running as the user can decrypt
secrets with it. `sops` fetches it through `sudo`, so editing a secrets file
asks for Touch ID. sops-nix only sets itself up once a secret is declared; on
a new machine it then generates the key, whose public half must be added to
`.sops.yaml` before its secrets can be decrypted.
*/
{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.sops-nix.darwinModules.sops];

  sops.age = {
    keyFile = "/var/lib/sops-nix/key.txt";
    generateKey = true;
  };

  environment.systemPackages = with pkgs; [
    sops
    age
  ];

  environment.variables.SOPS_AGE_KEY_CMD = "sudo cat ${config.sops.age.keyFile}";
}
