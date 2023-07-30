{
  imports = [
    ../../roles/desktop.nix

    ./hardware.nix
    ./nvidia.nix
    ./storage.nix
  ];

  networking.hostName = "citadel-core";
  
  base.user.george.enable = true;
  base.hidpi.enable = true;
  base.hyprland.enable = true;
  base.hyprland.extraConfig = ''
    monitor=DP-2, highres, 0x0, 2

    workspace = 1, monitor:DP-2, default:true
    workspace = 2, monitor:DP-2, default:false
    workspace = 3, monitor:DP-2, default:false
    workspace = 4, monitor:DP-2, default:true
    workspace = 5, monitor:DP-2, default:false
    workspace = 6, monitor:DP-2, default:false
    workspace = 7, monitor:DP-2, default:true
    workspace = 8, monitor:DP-2, default:false
    workspace = 9, monitor:DP-2, default:false
  '';
  
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