{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.base.vlc;
in
{
  options.base.vlc = {
    enable = mkEnableOption "vlc";

    default = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      vlc
    ];

    home.file.".config/vlc/vlcrc".text = ''
        [core]
        vout=xcb_x11
        metadata-network-access=1
        [qt]
        qt-privacy-ask=0
        [avcodec]
        avcodec-hw=none
    '';

    xdg.mimeApps = mkIf cfg.default {
      enable = true;
      defaultApplications = {
        "audio/mp4" = ["vlc.desktop"];
        # NOTE: Apps are symlinked from /etc/profiles/per-user/USERNAME/share/applications/
      };
    };
  };
}
