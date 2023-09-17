

{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.base.direnv;
in
{
  options.base.direnv = {
    enable = mkEnableOption "direnv";
  };

  config = mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}