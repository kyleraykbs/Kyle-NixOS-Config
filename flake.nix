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

      mkNixos = system: config: nixpkgs.lib.nixosSystem {
        inherit specialArgs system;
        modules = [ ./modules/nixos config ];
      };

      mkHome = config: home-manager.lib.homeManagerConfiguration {
        pkgs = fpkgs;
        extraSpecialArgs = specialArgs;
        modules = [ ./overlays.nix ./modules/home config ];
      };
    in {

      nixosConfigurations = {
        comet = mkNixos "x86_64-linux" ./hosts/comet;
      };

      homeConfigurations = {
        "kyle@comet" = mkHome ./home/kyle/comet.nix;
      };
    };
}