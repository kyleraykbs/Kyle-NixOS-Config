{pkgs, config, inputs, lib, ...}: {
  imports = [inputs.stylix.nixosModules.stylix];

  stylix.image = config.base.wallpaper;
  stylix.polarity = "dark";
  stylix.autoEnable = lib.mkDefault false;

  programs = {
    fish = { enable = true; };
  };

  base.flakes.enable = true;

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    font-awesome
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1u"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n = rec {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = defaultLocale;
      LC_IDENTIFICATION = defaultLocale;
      LC_MEASUREMENT = defaultLocale;
      LC_MONETARY = defaultLocale;
      LC_NAME = defaultLocale;
      LC_NUMERIC = defaultLocale;
      LC_PAPER = defaultLocale;
      LC_TELEPHONE = defaultLocale;
      LC_TIME = defaultLocale;
    };
  };

  environment.systemPackages = with pkgs; [
    neofetch
    git
    htop
    socat
    nix-index
    pciutils
    zip
    unzip
  ];

  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.firewall.enable = false;

  system.stateVersion = "23.05"; 
}
