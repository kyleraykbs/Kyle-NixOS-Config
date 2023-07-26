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
    user.luna = {
      enable = mkEnableOption "Luna User";

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

  config = mkIf cfg.user.luna.enable {
    users = {
      defaultUserShell=pkgs.fish;
      users.luna = {
        isNormalUser = true;
        description = "Luna Rivera";
        extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
      };
    };
    
    security.sudo.extraRules= [
      { users = [ "luna" ];
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
    home-manager.users.luna = mkMerge [
      cfg.homeConfig
      cfg.user.luna.homeConfig
      {
        imports = [
          ../../home
          (../../../home/luna + "/${config.networking.hostName}.nix")
        ];

        home.username = "luna";
        home.homeDirectory = "/home/luna";

        programs.home-manager.enable = true;

        base = recursiveUpdate
          cfg.homeBaseConfig
          cfg.user.luna.baseConfig;
      }
    ];
  };
}