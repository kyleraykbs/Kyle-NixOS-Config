{
  imports = [
    ../../roles/desktop.nix

    ./hardware.nix
    ./nvidia.nix
    ./storage.nix
  ];

  networking.hostName = "comet";
  
  base.user.kyle.enable = true;

  base.hyprland.enable = true;
  base.hyprland.extraConfig = ''
    monitor=DP-1, highrr, 1920x0, 1
    monitor=HDMI-A-1, 1920x1080@60, 0x0, 1
    #monitor=HDMI-A-1,transform,1
    monitor=DVI-D-2, 1920x1080@60, 3840x0, 1
    monitor=, preffered, 1920x0, 1

    workspace = 1, monitor:DP-1, default:true
    workspace = 2, monitor:DP-1, default:false
    workspace = 3, monitor:DP-1, default:false

    workspace = 4, monitor:DVI-D-2, default:true
    workspace = 5, monitor:DVI-D-2, default:false
    workspace = 6, monitor:DVI-D-2, default:false

    workspace = 7, monitor:HDMI-A-1, default:true
    workspace = 8, monitor:HDMI-A-1, default:false
    workspace = 9, monitor:HDMI-A-1, default:false
  '';
  
  services = {
    syncthing = {
        enable = true;
        user = "kyle";
        dataDir = "/home/kyle/Documents/Sync";    # Default folder for new synced folders
        configDir = "/home/kyle/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
  };

  base.virtualisation.enable = true;
}