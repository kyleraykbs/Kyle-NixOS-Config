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

    hardware.opengl.driSupport32Bit = true;
    environment.systemPackages = with pkgs; [
      egl-wayland
      libva-utils
      nvidia-vaapi-driver
    ];

    hardware.opengl = {
        enable = true;

        # Vulkan
        driSupport = true;

        # VA-API
        extraPackages = with pkgs; [
          vaapiVdpau
          libvdpau-va-gl

          # Test
          nvidia-vaapi-driver
        ];
      };

    # nixpkgs.config.cudaSupport = true;


    environment.sessionVariables = mkMerge [{
      # CUDA
      #CUDA_PATH = "${pkgs.cudatoolkit}";
      EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
      EXTRA_CCFLAGS="-I/usr/include";
    }

    (mkIf cfg.waylandFixups {
      LIBVA_DRIVER_NAME="nvidia";
      WLR_NO_HARDWARE_CURSORS="1";
      GBM_BACKEND = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME="nvidia";
      __EGL_VENDOR_LIBRARY_FILENAMES="${pkgs.linuxPackages.nvidia_x11}/share/glvnd/egl_vendor.d/10_nvidia.json";
      MOZ_DISABLE_RDD_SANDBOX="1";
      NVD_BACKEND="direct";
      # XDG_SESSION_TYPE = "wayland";
      # WLR_BACKEND = "vulkan";
      # WLR_RENDERER = "vulkan";
    })];

    hardware.nvidia = {
      modesetting.enable = true; #! THIS IS REQUIRED FOR HYPRLAND
      open = cfg.open;
      # nvidiaSettings = true;
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
