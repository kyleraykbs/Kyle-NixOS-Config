{ config, lib, pkgs, modulesPath, ... }:{
    fileSystems."/" =
    { device = "/dev/disk/by-uuid/2bf1ac34-637b-478f-928b-44282c8f2159";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/C98B-3B56";
      fsType = "vfat";
    };

  swapDevices = [];
}