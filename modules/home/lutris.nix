

{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.base.lutris;
in
{
  options.base.lutris = {
    enable = mkEnableOption "lutris";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      (self: super:
        { lutris = super.lutris.override { extraLibraries = pkgs: [pkgs.libunwind ]; }; })
    ];

    home.packages = with pkgs; [
      lutris
    ];
  };
}