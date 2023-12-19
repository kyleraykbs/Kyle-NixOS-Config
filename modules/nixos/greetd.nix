{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.base.greetd;
in
{
  options.base.greetd = {
    enable = mkEnableOption "Greetd";

    autologin = mkOption {
      type = types.bool;
      default = true;
    };

    desktopenv = mkOption {
      type = types.str;
      default = "hyprland";
    };

    user = mkOption {
      type = types.str;
      default = "NO USER SPECIFIED";
    };
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.sddm.enable = lib.mkForce false; 
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = (if cfg.desktopenv == "hyprland" then "Hyprland" else if cfg.desktopenv == "sway" then "sway" else "");
          user = cfg.user;
        };
        default_session = initial_session;
      };
    };
  };
}
