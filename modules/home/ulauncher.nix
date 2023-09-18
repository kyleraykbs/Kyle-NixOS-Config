{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.base.ulauncher;
in
{
  options.base.ulauncher = {
    enable = mkEnableOption "ulauncher";

    theme = mkOption {
      type = types.str;
      default = "adwaita";
    };

    searchurl = mkOption {
      type = types.str;
      default = "https://search.brave.com/search?q=%s";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ulauncher
    ];

    home.file.".config/ulauncher/settings.json".text = ''
      {
        "blacklisted-desktop-dirs": "/usr/share/locale:/usr/share/app-install:/usr/share/kservices5:/usr/share/fk5:/usr/share/kservicetypes5:/usr/share/applications/screensavers:/usr/share/kde4:/usr/share/mimelnk",
        "clear-previous-query": true,
        "disable-desktop-filters": false,
        "grab-mouse-pointer": false,
        "hotkey-show-app": "<Primary>space",
        "render-on-screen": "mouse-pointer-monitor",
        "show-indicator-icon": true,
        "show-recent-apps": "0",
        "terminal-command": "",
        "theme-name": "${cfg.theme}"
      }
    '';
  };
}