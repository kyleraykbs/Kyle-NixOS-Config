{config, lib, pkgs, ...}: 
{
  imports = [
    ./stylix
    ./hyprland.nix
    ./kdeconnect.nix
    ./pcmanfm.nix
    ./discord.nix
    ./base.nix
    ./neovim.nix
    ./fish.nix
    ./waybar.nix
    ./direnv.nix
  ];
}
