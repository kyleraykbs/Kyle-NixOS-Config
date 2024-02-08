{
  description = "NixOS configuration";

  inputs = {
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    stylix = {
        url = "github:danth/stylix";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
        url = "github:nix-community/home-manager/master";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs:
    with inputs;
    let
      system = "x86_64-linux";
      specialArgs = { inherit inputs self; };

      mkNixos = system: config: nixpkgs.lib.nixosSystem {
        inherit specialArgs system;
        modules = [
        ./overlays.nix
        ./modules/nixos config
        sops-nix.nixosModules.sops
        ];
      };

      mkHome = config: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        extraSpecialArgs = specialArgs;
        modules = [ ./overlays.nix ./modules/home config ];
      };
    in {

      nixosConfigurations = {
        comet = mkNixos "x86_64-linux" ./hosts/comet;
        citadel-core = mkNixos "x86_64-linux" ./hosts/citadel-core;
        baha-blast = mkNixos "x86_64-linux" ./hosts/baha-blast;
        stardust = mkNixos "x86_64-linux" ./hosts/stardust;
        borealis = mkNixos "x86_64-linux" ./hosts/borealis;
      };

      homeConfigurations = {
        "kyle@comet" = mkHome ./home/kyle/comet.nix;
        "george@citadel-core" = mkHome ./home/george/citadel-core.nix;
        "luna@baha-blast" = mkHome ./home/luna/baha-blast.nix;
        "kyle@stardust" = mkHome ./home/kyle/stardust.nix;
        "kyle@borealis" = mkHome ./home/kyle/borealis.nix;
        "jon@borealis" = mkHome ./home/jon/borealis.nix;
      };
    };
}
 
