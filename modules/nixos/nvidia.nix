{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
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

    waylandFixups = mkOption {
      type = types.bool;
      default = true;
    };
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
    };

    services.xserver.videoDrivers = ["nvidia"];

    programs.hyprland.nvidiaPatches = true;

    environment.sessionVariables = mkIf cfg.waylandFixups {
      LIBVA_DRIVER_NAME = "vdapu";
      WLR_NO_HARDWARE_CURSORS="1";
      GBM_BACKEND = "nvidia-drm";
      WLR_DRM_NO_ATOMIC = "1";
      __GLX_VENDOR_LIBRARY_NAME="nvidia";
      # XDG_SESSION_TYPE = "wayland";
      # WLR_BACKEND = "vulkan";
      # WLR_RENDERER = "vulkan";
      NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
      nvidia-vaapi-driver
    ];

    hardware.nvidia = {
      # Modesetting is needed for most wayland compositors
      modesetting.enable = true; #! THIS IS REQUIRED FOR HYPRLAND

      # Use the open source version of the kernel module
      # Only available on driver 515.43.04+
      open = cfg.open;

      # Enable the nvidia settings menu
      # nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}