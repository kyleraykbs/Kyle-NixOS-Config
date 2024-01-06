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

  base.virtualisation.enable = true;
  base.virtualisation.hostcpus = "0-23";
  base.virtualisation.virtcpus = "22-23";
  base.virtualisation.cpuarch = "amd";
  base.virtualisation.acspatch = true;
  base.virtualisation = {
    vfioids = [
      "10de:2805"
      "10de:22bd"
      "1022:43bb"
    ];
  };

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    };  
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
