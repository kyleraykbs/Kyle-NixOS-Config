# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:
let
  # RTX 3070 Ti
  gpuIDs = [
    "10de:1b81" # Graphics
    "10de:10f0" # Audio
  ];
in
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    # "vfio_iommu_type1"
    # "vfio_virqfd"

    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [ "amd_iommu=on" "iommu=pt" "pcie_acs_override=downstream,multifunction" "kvm.ignore_msrs=1" ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs) ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d143e2cf-d65f-41f6-b96a-dd2fd1e4cd90";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7255-9D85";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/907492c7-2d87-49c9-8563-d60fccc44f7e"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}