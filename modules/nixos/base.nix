{lib, ...}: 
let
  shared = import ../../shared.nix;
  inherit (lib)
    mkOption
    types
    ;
in
{
  options.base = {
    wallpaper = mkOption {
      type = types.path;
      default = shared.style.wallpaper;
    };
  };
}
