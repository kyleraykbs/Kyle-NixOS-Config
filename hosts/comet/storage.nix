{ config, lib, pkgs, modulesPath, ... }: {
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d143e2cf-d65f-41f6-b96a-dd2fd1e4cd90";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7255-9D85";
      fsType = "vfat";
    };

  fileSystems."/nas" = 
    {
      device = "10.0.0.4:/volume1/Kyle";
      fsType = "nfs";
      options = [ "defaults" "user" "rw" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/907492c7-2d87-49c9-8563-d60fccc44f7e"; }
    ];
}