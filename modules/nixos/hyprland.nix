
{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  
  isHidpi = config.base.hidpi.enable;

  cfg = config.base.hyprland;
in
{
  options.base.hyprland = {
    enable = mkEnableOption "Hyprland";
  };

  config = mkIf cfg.enable {
    base.nvidia.waylandFixups = true;
    
    programs.hyprland = {
      enable = true;

      xwayland = {
        enable = true;
        # hidpi = false;
      };

      # nvidiaPatches = false;
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        # xdg-desktop-portal-wlr
        # xdg-desktop-portal-kde
      ];
    };
  };
}