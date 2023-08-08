{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.base.discord;
in
{
  options.base.discord = {
    enable = mkEnableOption "discord";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (discord.override {
        withOpenASAR = true;
        withVencord = true;
        withTTS = true;
      })
    ];
  };
}