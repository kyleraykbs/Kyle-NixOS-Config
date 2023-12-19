{ config, inputs, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.base.amd;
in
{
  options.base.amd = {
	  enable = mkEnableOption "amd";
  };
  config = mkIf cfg.enable {
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.initrd.kernelModules = [ "vfio" "vfio_pci" ];
  boot.kernelParams = [
    "video=hyperv_fb:1152x864"
    "video=DP-1:1920x1080@60m"
    "radeon.cik_support=0"
    "amdgpu.cik_support=1"
    "hw.syscons.disable=1"
    "amdgpu.dpm=1"
  ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
    enable = true;
  };

  };
}
