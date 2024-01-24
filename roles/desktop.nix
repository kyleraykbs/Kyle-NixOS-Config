{pkgs, config, inputs, lib, ...}: {
  imports = [
    inputs.stylix.nixosModules.stylix
    ./universal.nix
  ];

  programs = {
    fish = { enable = true; };
  };

  services.flatpak.enable = true;

  hardware.opentabletdriver.enable = true;

  stylix.image = config.shared.style.wallpaper;
  stylix.polarity = "dark";
  stylix.autoEnable = lib.mkDefault false;

  base.flakes.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowInsecurePredicate = pkg: true;

  fonts.packages = with pkgs; [
    font-awesome
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1u"
    "libav-11.12"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = lib.mkDefault "America/Los_Angeles";

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
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.displayManager.sddm.enable = lib.mkDefault true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    pulseaudio
    neofetch
    github-desktop
    git
    p7zip
    htop
    nix-index
    pciutils
    zip
    unzip
    ddcutil
    v4l-utils
    distrobox
    podman
    i2c-tools
    python3
  ];

  environment = {
    sessionVariables = {
      #LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
      PULSE_LATENCY_MSEC="50";
      PIPEWIRE_RATE="48000";
      PIPEWIRE_QUANTUM="128/48000";
      PIPEWIRE_LATENCY="0/48000";
    };
  };

  environment.etc = {
    "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
      context.properties = {
        default.clock.rate = 48000
        default.clock.quantum = 512
        default.clock.min-quantum = 512
        default.clock.max-quantum = 512
      }
    '';
  };

  boot.supportedFilesystems = [ "ntfs" "nfs" "btrfs" ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "i2c-dev" "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 video_nr=9 card_label=VirtualVideoDevice
    '';
  boot.initrd.kernelModules = [
    "vfio"
    "vfio_pci"
  ];

  programs.adb.enable = true;

  services.gvfs.enable = true;
  services.tumbler.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "23.05"; 
}
