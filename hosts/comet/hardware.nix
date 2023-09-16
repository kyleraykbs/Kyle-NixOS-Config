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

  base.virtualisation = {
    vfioids = [
      "10de:1b81"
      "10de:10f0"
    ];
    amd.enable = true;
  };

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    };  
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
