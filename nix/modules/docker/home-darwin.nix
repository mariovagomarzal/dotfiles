/**
Docker's engine in a Colima virtual machine, started at login through Home Manager.

Colima selects its Docker context without setting `DOCKER_HOST`, so `docker context use` can still select other engines.
The virtual machine uses Apple's Virtualization framework and VirtioFS to share `/Users` with write access.
Colima reads the profile as a complete configuration, so its resource sizes are specified explicitly.
*/
_: {
  services.colima = {
    enable = true;
    profiles.default = {
      isActive = true;
      isService = true;
      setDockerHost = false;
      settings = {
        cpu = 2;
        memory = 2;
        disk = 100;
        arch = "host";
        runtime = "docker";
        vmType = "vz";
        mountType = "virtiofs";
        mounts = [
          {
            location = "/Users";
            writable = true;
          }
        ];
        network.dnsHosts."host.docker.internal" = "host.lima.internal";
      };
    };
  };
}
