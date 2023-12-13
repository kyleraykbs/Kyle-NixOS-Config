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
            boilerplate = ''<controller type="usb" index="0" model="qemu-xhci" ports="15">
                          <address type="pci" domain="0x0000" bus="0x02" slot="0x00" function="0x0"/>
                        </controller>
                        <controller type="pci" index="0" model="pcie-root"/>
                        <controller type="pci" index="1" model="pcie-root-port">
                          <model name="pcie-root-port"/>
                          <target chassis="1" port="0x10"/>
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x0" multifunction="on"/>
                        </controller>
                        <controller type="pci" index="2" model="pcie-root-port">
                          <model name="pcie-root-port"/>
                          <target chassis="2" port="0x11"/>
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x1"/>
                        </controller>
                        <controller type="pci" index="3" model="pcie-root-port">
                          <model name="pcie-root-port"/>
                          <target chassis="3" port="0x12"/>
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x2"/>
                        </controller>
                        <controller type="pci" index="4" model="pcie-root-port">
                          <model name="pcie-root-port"/>
                          <target chassis="4" port="0x13"/>
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x3"/>
                        </controller>
                        <controller type="pci" index="5" model="pcie-root-port">
                          <model name="pcie-root-port"/>
                          <target chassis="5" port="0x14"/>
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x4"/>
                        </controller>
                        <controller type="pci" index="6" model="pcie-root-port">
                          <model name="pcie-root-port"/>
                          <target chassis="6" port="0x15"/>
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x5"/>
                        </controller>
                        <controller type="pci" index="7" model="pcie-root-port">
                          <model name="pcie-root-port"/>
                          <target chassis="7" port="0x16"/>
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x6"/>
                        </controller>
                        <controller type="pci" index="8" model="pcie-root-port">
                          <model name="pcie-root-port"/>
                          <target chassis="8" port="0x17"/>
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x02" function="0x7"/>
                        </controller>
                        <controller type="pci" index="9" model="pcie-root-port">
                          <model name="pcie-root-port"/>
                          <target chassis="9" port="0x18"/>
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x03" function="0x0" multifunction="on"/>
                        </controller>
                        <controller type="pci" index="10" model="pcie-root-port">
                          <model name="pcie-root-port"/>
                          <target chassis="10" port="0x19"/>
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x03" function="0x1"/>
                        </controller>
                        <controller type="pci" index="11" model="pcie-root-port">
                          <model name="pcie-root-port"/>
                          <target chassis="11" port="0x1a"/>
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x03" function="0x2"/>
                        </controller>
                        <controller type="pci" index="12" model="pcie-root-port">
                          <model name="pcie-root-port"/>
                          <target chassis="12" port="0x1b"/>
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x03" function="0x3"/>
                        </controller>
                        <controller type="pci" index="13" model="pcie-root-port">
                          <model name="pcie-root-port"/>
                          <target chassis="13" port="0x1c"/>
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x03" function="0x4"/>
                        </controller>
                        <controller type="pci" index="14" model="pcie-root-port">
                          <model name="pcie-root-port"/>
                          <target chassis="14" port="0x1d"/>
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x03" function="0x5"/>
                        </controller>
                        <controller type="sata" index="0">
                          <address type="pci" domain="0x0000" bus="0x00" slot="0x1f" function="0x2"/>
                        </controller>
                        <controller type="virtio-serial" index="0">
                          <address type="pci" domain="0x0000" bus="0x03" slot="0x00" function="0x0"/>
                        </controller>'';
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
