{
  imports = [
    ../../roles/desktop.nix

    ./hardware.nix
    ./storage.nix
  ];

  networking.hostName = "citadel-core";

  base.nvidia.enable = true;
  
  base.user.george.enable = true;
  base.hidpi.enable = true;
  base.hyprland.enable = true;

  # services.xserver.displayManager.autoLogin.user = "george";
  # services.xserver.displayManager.autoLogin.enable = true;


  services = {
    syncthing = {
        enable = true;
        user = "george";
        dataDir = "/home/george/Documents/Sync";    # Default folder for new synced folders
        configDir = "/home/george/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
  };

  base.virtualisation.enable = true;
}