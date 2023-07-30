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
        citadel-core = mkNixos "x86_64-linux" ./hosts/citadel-core;
        baha-blast = mkNixos "x86_64-linux" ./hosts/baha-blast;
        stardust = mkNixos "x86_64-linux" ./hosts/stardust;
      };

      homeConfigurations = {
        "kyle@comet" = mkHome ./home/kyle/comet.nix;
        "george@citadel-core" = mkHome ./home/george/citadel-core.nix;
        "luna@baha-blast" = mkHome ./home/luna/baha-blast.nix;
        "kyle@stardust" = mkHome ./home/kyle/stardust.nix;
      };
    };
}