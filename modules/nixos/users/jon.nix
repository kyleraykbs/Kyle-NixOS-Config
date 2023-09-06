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
    user.jon = {
      enable = mkEnableOption "Jon User";

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

  config = mkIf cfg.user.jon.enable {
    users = {
      defaultUserShell=pkgs.fish;
      users.jon = {
        isNormalUser = true;
        description = "Jon Kubis";
        extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
      };
    };
    
    security.sudo.extraRules= [
      { users = [ "Jon" ];
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
    home-manager.users.jon = mkMerge [
      cfg.homeConfig
      cfg.user.jon.homeConfig
      {
        imports = [
          ../../home
          (../../../home/jon + "/${config.networking.hostName}.nix")
        ];

        home.username = "jon";
        home.homeDirectory = "/home/jon";

        programs.home-manager.enable = true;

        base = recursiveUpdate
          cfg.homeBaseConfig
          cfg.user.jon.baseConfig;
      }
    ];
  };
}