{inputs, config, pkgs, ...}: let settings = (import ../../../settings.nix); in {
  stylix.image = settings.style.wallpaper;
  stylix.polarity = "dark";
}