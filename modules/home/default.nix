{config, lib, pkgs, ...}: 
{
  imports = [
    ./hardware/monitors.nix
    ./stylix
    ./hyprland.nix
    ./kdeconnect.nix
    ./pcmanfm.nix
    ./thunar.nix
    ./discord.nix
    ./base.nix
    ./neovim.nix
    ./fish.nix
    ./waybar.nix
    ./ulauncher.nix
    ./direnv.nix
    ./lutris.nix
    ./rofi.nix
    ./sway.nix
  ];
}
