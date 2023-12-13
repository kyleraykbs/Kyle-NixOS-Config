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

  base.virtualisation = {
    enable = true;
    virtualmachines = [
        {
            name="sussyvmvsixdnine";
            cpu = {
                cores = 16;
            };
            storage = {
                devices = [
                    {
                        path="/home/george/foobar.qcow2";
                        type="disk";
                        mountpoint="sda";
                        id="0";
                    }

                    {
                        path="/home/george/Downloads/Win10_22H2_English_x64v1.iso";
                        type="cdrom";
                        mountpoint="sdb";
                        id="1";
                    }
                ];
            };
            input = {
                keyboard = "/dev/input/by-id/usb-Razer_Razer_Ornata_Chroma-if01-event-kbd";
                mouse = "/dev/input/by-id/usb-E-Signal_USB_Gaming_Mouse-event-mouse";
            };
            passthrough = {
                devices = [
                    {
                        address = "01";
                        subaddress = "0";
                        virtaddress = "12"; # starts at 12 add 1
                    }

                    {
                        address = "01";
                        subaddress = "1";
                        virtaddress = "13"; # starts at 12 add 1
                    }
                ];
            };
        }
    ];
  };

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
