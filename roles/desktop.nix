{pkgs, config, inputs, lib, ...}: {
  imports = [
    inputs.stylix.nixosModules.stylix
    ./universal.nix
  ];

  programs = {
    fish = { enable = true; };
  };

  services.flatpak.enable = true;

  stylix.image = config.base.wallpaper;
  stylix.polarity = "dark";
  stylix.autoEnable = lib.mkDefault false;

  base.flakes.enable = true;

  nixpkgs.config.allowUnfree = true;

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

  environment.etc = {
      "pipewire/pipewire.conf.d/92-pipewire.conf".text = ''
        context.properties = {
          link.max-buffers = 128
          default.clock.rate = 48000
          default.clock.quantum = 128
          default.clock.min-quantum = 1024 
          default.clock.max-quantum = 16384
        }
      '';

      "wireplumber/main.lua.d/99-alsa-config.lua".text = ''
          alsa_monitor.rules = {
            {
              matches = {{{ "node.name", "matches", "alsa_output.*" }}};
              apply_properties = {
                ["audio.format"] = "S32LE",
                ["audio.rate"] = "96000", -- for USB soundcards it should be twice your desired rate
                ["api.alsa.period-size"] = 2048, -- defaults to 1024, tweak by trial-and-error
                ["api.alsa.use-acp"] = 0, 
                ["session.suspend-timeout-seconds"] = 0, 
              },
            },
          }
        '';
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
    };
  };

  boot.supportedFilesystems = [ "ntfs" "nfs" ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "i2c-dev" "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  programs.adb.enable = true;

  services.gvfs.enable = true;
  services.tumbler.enable = true;
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "23.05"; 
}
