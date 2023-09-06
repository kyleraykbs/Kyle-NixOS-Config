{ config, lib, pkgs, modulesPath, ... }:

{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/c9f253d1-56e0-439b-a544-c46ef251dcb7";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/DE55-BA2C";
      fsType = "vfat";
    };

  swapDevices = [ ];
}
