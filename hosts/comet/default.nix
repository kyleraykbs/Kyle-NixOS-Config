{
  imports = [
    ../../roles/desktop.nix

    ./hardware.nix
    ./storage.nix
  ];

  base.nvidia.enable = true;
  base.bluetooth.enable = true;

  networking.hostName = "comet";

  base.user.kyle.enable = true;
  base.greetd = {
    enable = true;
    user = "kyle";
    desktopenv = "hyprland";
  };

  base.hyprland.enable = true;

  # services.xserver.displayManager.autoLogin.user = "kyle";
  # services.xserver.displayManager.autoLogin.enable = true;

  base.virtualisation.enable = true;
  base.virtualisation.hostcpus = "0-23";
  base.virtualisation.virtcpus = "22-23";

  services = {
    syncthing = {
        enable = true;
        user = "kyle";
        dataDir = "/home/kyle/Documents/Sync";    # Default folder for new synced folders
        configDir = "/home/kyle/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
  };
}
