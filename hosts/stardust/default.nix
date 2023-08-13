{
  imports = [
    ../../roles/desktop.nix

    ./hardware.nix
    ./storage.nix
  ];

  networking.hostName = "stardust";
  
  base.user.kyle.enable = true;

  base.hyprland.enable = true;
  # base.virtualisation.enable = true;
}