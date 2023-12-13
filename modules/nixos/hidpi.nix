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
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
  };
}
