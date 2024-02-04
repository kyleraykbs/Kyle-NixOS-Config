{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.base.feh;
in
{
  options.base.feh = {
    enable = mkEnableOption "feh";

    default = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      feh
    ];

    xdg.mimeApps = mkIf cfg.default {
      enable = true;
      defaultApplications = {
        "image/png" = ["feh.desktop"];
        # NOTE: Apps are symlinked from /etc/profiles/per-user/USERNAME/share/applications/
      };
    };
  };
}
