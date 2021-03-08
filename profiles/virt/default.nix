{ pkgs, ... }: {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemuRunAsRoot = false;
      allowedBridges = [ "virbr0" "virbr1" ];
    };

    containers.enable = true;

    docker = {
      enable = true;
      autoPrune = { enable = true; };
    };
  };
}
