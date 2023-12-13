{
  imports = [
    ../../roles/desktop.nix

    ./hardware.nix
    ./storage.nix
  ];

  base.virtualisation = {
    enable = true;
    virtualmachines = [
        {
            name="testvm";
            cpu = {
                cores = 12;
            };
            storage = {
                devices = [
                    {
                        path="/home/kyle/Documents/VirtualMachines/Win10NoEntropy.qcow2";
                        type="disk";
                        mountpoint="sda";
                        id="0";
                    }

                    {
                        path="/home/kyle/Downloads/Win10_22H2_English_x64v1(1).iso";
                        type="cdrom";
                        mountpoint="sdb";
                        id="1";
                    }
                ];
            };
            input = {
                keyboard = "/dev/input/by-id/usb-Razer_Razer_Huntsman_Mini_00000000001A-event-kbd";
                mouse = "/dev/input/by-id/usb-Dell_Dell_USB_Optical_Mouse-event-mouse";
            };
            passthrough = {
                devices = [
                    {
                        # lspci -nn
                        #   05:00.1
                        #   ^^    ^
                        # ADDRESS Sub Address
                        address = "05";
                        subaddress = "0";
                        virtaddress = "12"; # starts at 12 add 1
                    }

                    {
                        # lspci -nn
                        #   05:00.1
                        #   ^^    ^
                        # ADDRESS Sub Address
                        address = "05";
                        subaddress = "1";
                        virtaddress = "13"; # starts at 12 add 1
                    }

                    {
                        # lspci -nn
                        #   05:00.1
                        #   ^^    ^
                        # ADDRESS Sub Address
                        address = "01";
                        subaddress = "1";
                        virtaddress = "14"; # starts at 12 add 1
                    }
                ];
            };
        }
    ];
  };
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

  services = {
    syncthing = {
        enable = true;
        user = "kyle";
        dataDir = "/home/kyle/Documents/Sync";    # Default folder for new synced folders
        configDir = "/home/kyle/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
  };
}
