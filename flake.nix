{
  description = "NixOS configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
  };

  outputs = inputs:
    with inputs;
    let
      system = "x86_64-linux";
      specialArgs = { inherit inputs self; };
    in {
      nixosConfigurations = {
        comet = nixpkgs.lib.nixosSystem {
          inherit specialArgs system;
          modules = [
            ./desktop/hyprland.nix
            ./hardware/nvidia.nix
            ./configuration.nix
            inputs.stylix.nixosModules.stylix
            ./software/emulation/virtual-machines.nix
            ./desktop/theme/autowallpaper/stylix.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {};
              home-manager.users.kyle = import ./homes/kyle/kyle.nix;
            }
          ];
        };
      };
    };
}