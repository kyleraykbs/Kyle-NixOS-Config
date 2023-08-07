{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.base.kdeconnect;
in
{
  options.base.kdeconnect = {
    enable = mkEnableOption "kdeconnect";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libsForQt5.kcmutils
      libsForQt5.kirigami-addons
      libsForQt5.kpeoplevcard
      libfakekey
      libsForQt5.modemmanager-qt
      libsForQt5.pulseaudio-qt
      libsForQt5.qca-qt5
      libsForQt5.qqc2-desktop-style
      libsForQt5.qt5.qttools
      libsForQt5.kdeconnect-kde
    ];
  };
}