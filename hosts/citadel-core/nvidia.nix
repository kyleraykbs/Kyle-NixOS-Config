{ config, lib, pkgs, modulesPath, ... }: {
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

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "vdapu";
    WLR_NO_HARDWARE_CURSORS="1";
    GBM_BACKEND = "nvidia-drm";
    WLR_DRM_NO_ATOMIC = "1";
    # XDG_SESSION_TYPE = "wayland";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # WLR_BACKEND = "vulkan";
    # WLR_RENDERER = "vulkan";
    NIXOS_OZONE_WL = "1";
  };

  hardware.nvidia = {
    # Modesetting is needed for most wayland compositors
    modesetting.enable = true; #! THIS IS REQUIRED FOR HYPRLAND

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    # open = true;

    # Enable the nvidia settings menu
    # nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}