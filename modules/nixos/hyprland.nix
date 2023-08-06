
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
    environment.systemPackages = with pkgs; [
      wofi
      wl-clipboard
      vaapiVdpau
      slurp
      polkit_gnome
      wlr-randr
      grim
    ];

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