{ config, inputs, lib, self, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkMerge
    mkOption
    recursiveUpdate
    types
    ;

  cfg = config.base;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.base = {
    homeConfig = mkOption {
      type = types.attrs;
      default = { };
    };

    homeBaseConfig = mkOption {
      type = types.attrs;
      default = { };
    };
  };
}