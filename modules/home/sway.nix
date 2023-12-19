{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.base.sway;
in
{
  options.base.sway = {
    enable = mkEnableOption "sway";

    default = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway = {
        enable = true;
        config = rec {
          modifier = "Mod4";
          # Use kitty as default terminal
          terminal = "kitty"; 
          startup = [
            # Launch Firefox on start
            {command = "firefox";}
          ];
        };
      };
  };
}
