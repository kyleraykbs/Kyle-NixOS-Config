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

            boilerplate = ''<controller type='usb' index='0' model='qemu-xhci' ports='15'>
                          <address type='pci' domain='0x0000' bus='0x02' slot='0x00' function='0x0'/>
                        </controller>
                        <controller type='pci' index='0' model='pcie-root'/>
                        <controller type='pci' index='1' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='1' port='0x8'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x0' multifunction='on'/>
                        </controller>
                        <controller type='pci' index='2' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='2' port='0x9'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x1'/>
                        </controller>
                        <controller type='pci' index='3' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='3' port='0xa'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x2'/>
                        </controller>
                        <controller type='pci' index='4' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='4' port='0xb'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x3'/>
                        </controller>
                        <controller type='pci' index='5' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='5' port='0xc'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x4'/>
                        </controller>
                        <controller type='pci' index='6' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='6' port='0xd'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x5'/>
                        </controller>
                        <controller type='pci' index='7' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='7' port='0xe'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x6'/>
                        </controller>
                        <controller type='pci' index='8' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='8' port='0xf'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x7'/>
                        </controller>
                        <controller type='pci' index='9' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='9' port='0x10'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x0' multifunction='on'/>
                        </controller>
                        <controller type='pci' index='10' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='10' port='0x11'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x1'/>
                        </controller>
                        <controller type='pci' index='11' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='11' port='0x12'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x2'/>
                        </controller>
                        <controller type='pci' index='12' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='12' port='0x13'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x3'/>
                        </controller>
                        <controller type='pci' index='13' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='13' port='0x14'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x4'/>
                        </controller>
                        <controller type='pci' index='14' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='14' port='0x15'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x5'/>
                        </controller>
                        <controller type='pci' index='15' model='pcie-root-port'>
                          <model name='pcie-root-port'/>
                          <target chassis='15' port='0x16'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x6'/>
                        </controller>
                        <controller type='pci' index='16' model='pcie-to-pci-bridge'>
                          <model name='pcie-pci-bridge'/>
                          <address type='pci' domain='0x0000' bus='0x07' slot='0x00' function='0x0'/>
                        </controller>
                        <controller type='sata' index='0'>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x1f' function='0x2'/>
                        </controller>
                        <controller type='virtio-serial' index='0'>
                          <address type='pci' domain='0x0000' bus='0x03' slot='0x00' function='0x0'/>
                        </controller>'';
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
