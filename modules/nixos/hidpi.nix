{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.hidpi;
in
{
  options.base.hidpi = {
    enable = mkEnableOption "My Thing";
  };

  config = mkIf cfg.enable {
    programs.hyprland.xwayland.hidpi = true;
  };
}