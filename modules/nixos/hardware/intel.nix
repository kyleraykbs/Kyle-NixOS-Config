{ config, inputs, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.base.intel;
in
{
  options.base.intel = {
	  enable = mkEnableOption "Intel";
      no_power_management = mkOption {
        type = types.bool;
        default = true;
      };
  };

  config = mkIf cfg.enable {
    boot.kernelParams = mkIf cfg.no_power_management[ "i915.enable_dc=0" "intel_idle.max_cstate=1" "intel_pstate=disable" ];

    nixpkgs.config.packageOverrides = pkgs: {
        vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
      };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  };
}
