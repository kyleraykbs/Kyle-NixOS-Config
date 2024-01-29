{ inputs, pkgs, self, ... }:
with inputs;
let
  system = pkgs.stdenv.hostPlatform.system;

  overlay-stable = final: prev: {
    stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  };

  overlay-flake = final: prev: {
    flake = self.packages.${system};
  };
in
{
  nixpkgs.overlays = [
    nur.overlay
    overlay-stable
    overlay-flake
  ];
}
