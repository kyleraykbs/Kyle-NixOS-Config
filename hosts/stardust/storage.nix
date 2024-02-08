{config, lib, pkgs, modulesPath, ...}: {
fileSystems."/" =
    { device = "/dev/disk/by-uuid/36b9fb85-da1d-4492-9248-f1ce60b6c6f3";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B91F-1673";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/4912f094-722e-4482-8406-354e0700f211"; }
    ];
}