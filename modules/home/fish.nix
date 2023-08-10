{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  custompkgs = {
    grc = {
      name = "grc";
      src = pkgs.fetchFromGitHub {
          owner = "garabik";
          repo = "grc";
          rev = "f4a579e08d356a3ea00a8c6fda7de84fff5f676a";
          sha256 = "sha256-bv+m+850edLSmo2/mlFUlYmcV8NJ5bxsa0jHyEl0Rp8=";
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
        custompkgs.grc
      ];
    };
  };
}