{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;

  cfg = config.base.neofetch;
in
{
  options.base.neofetch = {
      enable = mkOption {
          type = types.bool;
          default = true;
      };
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      neofetch
    ];

    home.file = {
    #  ".config/neofetch/config.conf".source = ./config.conf;
    };

    #systemd.user.tmpfiles.rules = [ "L .config/neofetch/ - - - - ${./logo.svg}" ];
  };
}
