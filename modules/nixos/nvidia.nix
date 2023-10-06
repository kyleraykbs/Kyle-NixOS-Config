{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    mkMerge
    ;

  cfg = config.base.nvidia;
in
{
  options.base.nvidia = {
    enable = mkEnableOption "Nvidia";
    # GTX 1650 AND NEWER ONLY
    open = mkOption {
      type = types.bool;
      default = false;
    };

    waylandFixups = mkEnableOption "Nvidia Wayland Fixups";
  };

  config = mkIf cfg.enable {
    boot = {
      initrd.kernelModules = [
        "vfio"
        "vfio_pci"
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];
      kernelParams = [
	"video=vesafb:off,efifb:off"
      ];
    };

    services.xserver.videoDrivers = ["nvidia"];

    programs.hyprland.enableNvidiaPatches = true;


    environment.systemPackages = with pkgs; [
      nvidia-vaapi-driver
      cudatoolkit
    ];

    # nixpkgs.config.cudaSupport = true;


    environment.sessionVariables = mkMerge [{
      # CUDA
      CUDA_PATH = "${pkgs.cudatoolkit}";
      EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
      EXTRA_CCFLAGS="-I/usr/include";
    }

    (mkIf cfg.waylandFixups {
      LIBVA_DRIVER_NAME = "vdapu";
      WLR_NO_HARDWARE_CURSORS="1";
      GBM_BACKEND = "nvidia-drm";
      WLR_DRM_NO_ATOMIC = "1";
      __GLX_VENDOR_LIBRARY_NAME="nvidia";
      # XDG_SESSION_TYPE = "wayland";
      # WLR_BACKEND = "vulkan";
      # WLR_RENDERER = "vulkan";
      NIXOS_OZONE_WL = "1";
    })];

    hardware.nvidia = {
      modesetting.enable = true; #! THIS IS REQUIRED FOR HYPRLAND
      open = cfg.open;
      # nvidiaSettings = true;
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
