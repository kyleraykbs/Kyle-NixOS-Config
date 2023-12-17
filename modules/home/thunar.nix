{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.base.thunar;
in
{
  options.base.thunar = {
    enable = mkEnableOption "thunar";
    
    default = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      mate.engrampa
      xfce.thunar
    ];

    xdg.mimeApps = mkIf cfg.default {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["thunar.desktop"];
        "application/zip" = ["engrampa.desktop"];
        # NOTE: Apps are symlinked from /etc/profiles/per-user/USERNAME/share/applications/
      };
    };
  };
}
