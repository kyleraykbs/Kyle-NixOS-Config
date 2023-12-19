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
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway = {
        enable = true;
        config = rec {
          modifier = "Mod4";
          terminal = "kitty"; 
          startup = [];
        };
      };
  };
}
