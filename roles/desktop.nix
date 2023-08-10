{pkgs, config, inputs, ...}: {
  imports = [inputs.stylix.nixosModules.stylix];

  programs = {
    fish = { enable = true; };
  };

  stylix.image = config.base.wallpaper;
  stylix.polarity = "dark";

  base.flakes.enable = true;

  nixpkgs.config.allowUnfree = true;

  fonts.fonts = with pkgs; [
    nerdfonts
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

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.displayManager.sddm.enable = true;

  hardware.opengl = {
    enable = true;
    # driSupport = true;
    # driSupport32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    neofetch
    github-desktop
    git
    htop
    nix-index
    pciutils
    zip
    unzip
    jdk17
    ddcutil
    v4l-utils
    wf-recorder
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "i2c-dev" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "23.05"; 
}