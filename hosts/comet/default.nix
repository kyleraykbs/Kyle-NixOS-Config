{
  imports = [
    ../../roles/desktop.nix

    ./hardware.nix
    ./nvidia.nix
    ./storage.nix
  ];

  networking.hostName = "comet";

  base.hyprland.enable = true;
  base.virtualisation.enable = true;
}