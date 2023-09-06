{
  imports = [
    ../../roles/desktop.nix

    ./hardware.nix
    ./storage.nix
  ];

  networking.hostName = "stardust";
  
  base.user.kyle.enable = true;

  base.hyprland.enable = true;

  base.bluetooth.enable = true;
  # base.virtualisation.enable = true;

  services = {
    syncthing = {
        enable = true;
        user = "kyle";
        dataDir = "/home/kyle/Documents/Sync";    # Default folder for new synced folders
        configDir = "/home/kyle/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
  };
}