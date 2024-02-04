{config, lib, pkgs, ...}: 
{
  imports = [
    ./feh.nix
    ./neofetch
    ./hardware/monitors.nix
    ./stylix
    ./hyprland.nix
    ./kdeconnect.nix
    ./pcmanfm.nix
    ./thunar.nix
    ./discord.nix
    ./neovim.nix
    ./fish.nix
    ./waybar.nix
    ./ulauncher.nix
    ./direnv.nix
    ./lutris.nix
    ./rofi.nix
    ./sway.nix
    ./vscode.nix
    ./vlc.nix
    ../../shared.nix
  ];
}
