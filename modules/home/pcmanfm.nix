{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.base.pcmanfm;
in
{
  options.base.pcmanfm = {
    enable = mkEnableOption "pcmanfm";
    
    default = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      mate.engrampa
      pcmanfm
    ];

    xdg.mimeApps = mkIf cfg.default {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["pcmanfm.desktop"];
        "application/zip" = ["engrampa.desktop"]; 
        # NOTE: Apps are symlinked from /etc/profiles/per-user/USERNAME/share/applications/
      };
    };
  };
}