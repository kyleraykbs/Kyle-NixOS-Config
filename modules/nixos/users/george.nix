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
    user.george = {
      enable = mkEnableOption "George User";

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

  config = mkIf cfg.user.george.enable {
    users = {
      defaultUserShell=pkgs.fish;
      users.george = {
        isNormalUser = true;
        description = "George Wolfe";
        extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
      };
    };
    
    security.sudo.extraRules= [
      { users = [ "george" ];
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
    home-manager.users.george = mkMerge [
      cfg.homeConfig
      cfg.user.george.homeConfig
      {
        imports = [
          ../../home
          (../../../home/george + "/${config.networking.hostName}.nix")
        ];

        home.username = "george";
        home.homeDirectory = "/home/george";

        programs.home-manager.enable = true;

        base = recursiveUpdate
          cfg.homeBaseConfig
          cfg.user.george.baseConfig;
      }
    ];
  };
}