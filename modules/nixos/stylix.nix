{ config, inputs, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.stylix;
in
{
  options.base.stylix = {
    enable = mkEnableOption "Stylix";
  };

  config = mkIf cfg.enable {
    stylix.autoEnable = false;
  };
}