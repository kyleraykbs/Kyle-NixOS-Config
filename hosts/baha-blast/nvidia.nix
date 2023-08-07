{ config, lib, pkgs, modulesPath, ... }: {
  boot = {
    initrd.kernelModules = [
      "vfio"
      "vfio_pci"
    ];
  };
}
