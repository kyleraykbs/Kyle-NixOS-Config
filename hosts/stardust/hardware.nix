{config, lib, pkgs, modulesPath, ...}: {
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.initrd.supportedFilesystems = ["nfs"];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ae3cd33e-6d20-4d50-aa35-39a5fc18ba0c";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-31c0cc61-8114-4967-b31f-591593cd74ea".device = "/dev/disk/by-uuid/31c0cc61-8114-4967-b31f-591593cd74ea";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3CF1-2E89";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/63742d2f-5863-4624-adb4-eb31517bd8a6"; }
    ];

    # Setup keyfile
  # boot.initrd.secrets = {
  #   "/crypto_keyfile.bin" = null;
  # };

  # # Enable swap on luks
  # boot.initrd.luks.devices."luks-0646a84a-36f8-48e4-8666-1e3d3570d79a".device = "/dev/disk/by-uuid/0646a84a-36f8-48e4-8666-1e3d3570d79a";
  # boot.initrd.luks.devices."luks-0646a84a-36f8-48e4-8666-1e3d3570d79a".keyFile = "/crypto_keyfile.bin";

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s25.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
