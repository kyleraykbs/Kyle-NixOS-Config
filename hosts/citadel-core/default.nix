{
  imports = [
    ../../roles/desktop.nix

    ./hardware.nix
    ./storage.nix
  ];

  networking.hostName = "citadel-core";

  base.user.george.enable = true;
  base.greetd = {
    enable = true;
    user = "george";
    desktopenv = "hyprland";
  };

  base.hidpi.enable = true;
  base.hyprland.enable = true;

  # services.xserver.displayManager.autoLogin.user = "george";
  # services.xserver.displayManager.autoLogin.enable = true;

  base.virtualisation.enable = true;
  base.virtualisation.hostcpus = "0-31";
  base.virtualisation.virtcpus = "30-31";

  services = {
    syncthing = {
        enable = true;
        user = "george";
        dataDir = "/home/george/Documents/Sync";    # Default folder for new synced folders
        configDir = "/home/george/.config/syncthing";   # Folder for Syncthing's settings and keys
    };

    openssh = {  
      enable = true;  
      ports = [27069];
    };
  };
}
