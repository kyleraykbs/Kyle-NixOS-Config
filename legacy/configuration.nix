# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking.hostName = "comet";

  imports =
  [
    ./hardware-configuration.nix
    ./common.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kyle = {
    isNormalUser = true;
    description = "Kyle Kubis";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      
    ];
  };

  security.sudo.extraRules= [
  { users = [ "kyle" ];
      commands = [
        { command = "ALL" ;
        options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];

  fonts.fonts = with pkgs; [
    nerdfonts
  ];
}
