{
  imports = [
    ../../roles/desktop.nix

    ./hardware.nix
#    ./nvidia.nix
    ./storage.nix
  ];

  base.user.luna.enable = true;
  networking.hostName = "baha-blast";

  base.hyprland.enable = true;
  
  services = {
    syncthing = {
        enable = true;
        user = "luna";
        dataDir = "/home/luna/Documents/Sync";    # Default folder for new synced folders
        configDir = "/home/luna/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
  };

  base.virtualisation.enable = true;
}