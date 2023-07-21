{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.virtualisation;
in
{
  options.base.virtualisation = {
    enable = mkEnableOption "My Thing";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };
    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [
      virt-manager
      qemu
    ];
  };
}