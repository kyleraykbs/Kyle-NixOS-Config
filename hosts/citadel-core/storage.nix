# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/fc9c043f-06d9-49fa-bebd-706137640638";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B205-A19A";
      fsType = "vfat";
    };

  fileSystems."/home/george/All Files" =
    { device = "/dev/disk/by-uuid/050d8efc-17cc-4725-a039-b9ad9ec5240e";
      fsType = "ext4";
    };

  swapDevices = [ ];
}
