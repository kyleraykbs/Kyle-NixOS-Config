{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.base.NAME;
in
{
  options.base.NAME = {
    enable = mkEnableOption "DESCRIPTION";
  };

  config = mkIf cfg.enable {
    
  };
}
