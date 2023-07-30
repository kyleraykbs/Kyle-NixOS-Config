{ config, lib, pkgs, modulesPath, ... }: {
  networking = { 
    useDHCP = false;

    interfaces = {
      eno1.useDHCP = true;
      br0.useDHCP = true;
    };

    bridges = {
      "br0" = {
        interfaces = [ "eno1" ];
      };
    };
  };

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    };

    kernelParams = [ 
      "amd_iommu=on" 
      "iommu=pt"
      "pcie_acs_override=downstream,multifunction" 
      "kvm.ignore_msrs=1" 
      "vfio-pci.ids=10de:1b81,10de:10f0"
    ];
    kernelModules = [
      "kvm-amd"
    ];
  };

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-0646a84a-36f8-48e4-8666-1e3d3570d79a".device = "/dev/disk/by-uuid/0646a84a-36f8-48e4-8666-1e3d3570d79a";
  boot.initrd.luks.devices."luks-0646a84a-36f8-48e4-8666-1e3d3570d79a".keyFile = "/crypto_keyfile.bin";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
