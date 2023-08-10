{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  custompkgs = {
    bass = {
      name = "bass";
      src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "f3a547b0239cf8529d35c1922dd242bacf751d3b";
          sha256 = "sha256-3mFlFiqGfQ+GfNshwKfhQ39AuNMdt8Nv2Vgb7bBV7L4=";
      };
    };
    grc = {
      name = "grc";
      src = pkgs.fetchFromGitHub {
          owner = "garabik";
          repo = "grc";
          rev = "f4a579e08d356a3ea00a8c6fda7de84fff5f676a";
          sha256 = "sha256-3mFlFiqGfQ+GfNshwKfhQ39AuNMdt8Nv2Vgb7bBV7L4=";
      };
    };
  };

  cfg = config.base.fish;
in
{
  options.base.fish = {
    enable = mkEnableOption "Fish";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
      plugins = [
        # Enable a plugin (here grc for colorized command output) from nixpkgs
        custompkgs.bass
        custompkgs.grc
      ];
    };
  };
}