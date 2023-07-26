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
    user.kyle = {
      enable = mkEnableOption "Kyle User";

      homeConfig = mkOption {
        type = types.attrs;
        default = { };
      };

      baseConfig = mkOption {
        type = types.attrs;
        default = { };
      };
    };
  };

  config = mkIf cfg.user.kyle.enable {
    users = {
      defaultUserShell=pkgs.fish;
      users.kyle = {
        isNormalUser = true;
        description = "Kyle Kubis";
        extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
      };
    };
    
    security.sudo.extraRules= [
      { users = [ "kyle" ];
          commands = [
            { command = "ALL" ;
              options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
            }
          ];
        }
    ];

    home-manager.extraSpecialArgs = { inherit inputs self; };
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.kyle = mkMerge [
      cfg.homeConfig
      cfg.user.kyle.homeConfig
      {
        imports = [
          ../../home
          (../../../home/kyle + "/${config.networking.hostName}.nix")
        ];

        home.username = "kyle";
        home.homeDirectory = "/home/kyle";

        programs.home-manager.enable = true;

        base = recursiveUpdate
          cfg.homeBaseConfig
          cfg.user.kyle.baseConfig;
      }
    ];
  };
}