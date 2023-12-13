{ config, lib, pkgs, writeText, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    mkMerge
    ;
  createFile = item: writeText "${item.name}.xml" "Thi is the content for ${item.name}";
  buildvms = lib.concatMapStringsSep "\n" createFile cfg.virtualmachines;



  cfg = config.base.virtualisation;
in
rec {
  options.base.virtualisation = {
    enable = mkEnableOption "virtualisation";

    intel = {
      enable = mkEnableOption "intel virtualisation";
    };

    amd = {
      enable = mkEnableOption "amd virtualisation";
    };

    virtualmachines = mkOption {
      type = types.listOf types.attrs;
      default = [
        # TEMPLATE OPTIONS
        /*
          {
            name = "vm-template";
            storage = {
              devices = [
                {
                    path="/home/someone/somfile";
                    type="disk"; # disk, cdrom, etc (finish documenting this)
                    mountpoint="sda"; # sda sdb sdc, etc
                    id="0"; # add one every new disk
                }
              ];
            };
            input = {
                keyboard = "/dev/input/by-id/XYZ-event-kbd";
                mouse = "/dev/input/by-id/XYZ-event-mouse";
            };
            passthrough = {
                devices = [
                    {
                        # lspci -nn
                        #   05:00.1
                        #   ^^    ^
                        # ADDRESS Sub Address
                        address = "05";
                        subaddress = "1";
                        virtaddress = "12"; # starts at 12 add 1 for each device
                    }
                ];
            };
            cpu = {
              cores = 11;
            };
          }
        */
      ];
    };

    vfioids = mkOption {
      type = types.listOf types.str;
      default = [
       # Get these using lspci -nn

       # TEMPLATE OPTIONS
       # "10de:1b81"
       # "10de:10f0"
      ];
    };
  };
 
  config = mkIf cfg.enable {
    ##################
    ### CREATE VMS ###
    ##################
    systemd.services.kyleos-create-vms-xml = {
        description = "Create vm xmls in /var/lib/libvirt/qemu";
        after = [ "libvirtd.service" ]; # Ensure libvirtd is started first
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.bash}/bin/bash ${pkgs.writeScript "create-main-xml" ''
                    mkdir -p /var/lib/libvirt/qemu
                    rm /var/lib/libvirt/qemu/*.xml
                    ${builtins.concatStringsSep "\n" (map(virt: let
                    in ''
                    cat > /var/lib/libvirt/qemu/${virt.name}.xml <<- EOM
                    <!--
                    WARNING: THIS IS AN AUTO-GENERATED FILE. CHANGES TO IT ARE LIKELY TO BE
                    OVERWRITTEN AND LOST. Changes to this xml configuration should be made using:
                      virsh edit ${virt.name}
                    or other application using the libvirt API.
                    -->

                    <domain type='kvm'>
                      <name>${virt.name}</name>
                      <uuid>6862f147-cc5f-4862-9119-5e53ebaf58a1</uuid>
                      <metadata>
                        <libosinfo:libosinfo xmlns:libosinfo="http://libosinfo.org/xmlns/libvirt/domain/1.0">
                          <libosinfo:os id="http://microsoft.com/win/10"/>
                        </libosinfo:libosinfo>
                      </metadata>
                      <memory unit='KiB'>18432000</memory>
                      <currentMemory unit='KiB'>16384000</currentMemory>
                      <vcpu placement='static'>${builtins.toString (virt.cpu.cores * 2)}</vcpu>
                      <os>
                        <type arch='x86_64' machine='pc-q35-8.0'>hvm</type>
                        <loader readonly='yes' type='pflash'>/run/libvirt/nix-ovmf/OVMF_CODE.fd</loader>
                        <nvram template='/run/libvirt/nix-ovmf/OVMF_VARS.fd'>/var/lib/libvirt/qemu/nvram/${virt.name}.fd</nvram>
                        <boot dev='hd'/>
                        <bootmenu enable='yes'/>
                      </os>
                      <features>
                        <acpi/>
                        <apic/>
                        <hyperv mode='custom'>
                          <relaxed state='on'/>
                          <vapic state='on'/>
                          <spinlocks state='on' retries='8191'/>
                        </hyperv>
                        <vmport state='off'/>
                      </features>
                      <cpu mode='host-model' check='partial'>
                        <topology sockets='1' dies='1' cores='${builtins.toString virt.cpu.cores}' threads='2'/>
                        <feature policy='require' name='topoext'/>
                      </cpu>
                      <clock offset='localtime'>
                        <timer name='rtc' tickpolicy='catchup'/>
                        <timer name='pit' tickpolicy='delay'/>
                        <timer name='hpet' present='no'/>
                        <timer name='hypervclock' present='yes'/>
                      </clock>
                      <on_poweroff>destroy</on_poweroff>
                      <on_reboot>restart</on_reboot>
                      <on_crash>destroy</on_crash>
                      <pm>
                        <suspend-to-mem enabled='no'/>
                        <suspend-to-disk enabled='no'/>
                      </pm>
                      <devices>
                        <emulator>/run/libvirt/nix-emulators/qemu-system-x86_64</emulator>
                        ${ lib.concatStringsSep "\n" (map (cdev: ''
                        <disk type='file' device='${cdev.type}'>
                              <driver name='qemu' type='${if cdev.type == "disk" then "qcow2" else "raw"}'/>
                              <source file='${cdev.path}'/>
                              <target dev='${cdev.mountpoint}' bus='sata'/>
                              <address type='drive' controller='0' bus='0' target='0' unit='${cdev.id}'/>
                            </disk>'') virt.storage.devices)}
                        <controller type='usb' index='0' model='qemu-xhci' ports='15'>
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
                        </controller>
                        <interface type='bridge'>
                          <mac address='52:54:00:7e:e8:07'/>
                          <source bridge='br0'/>
                          <model type='e1000e'/>
                          <address type='pci' domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
                        </interface>
                        <serial type='pty'>
                          <target type='isa-serial' port='0'>
                            <model name='isa-serial'/>
                          </target>
                        </serial>
                        <console type='pty'>
                          <target type='serial' port='0'/>
                        </console>
                        <channel type='spicevmc'>
                          <target type='virtio' name='com.redhat.spice.0'/>
                          <address type='virtio-serial' controller='0' bus='0' port='1'/>
                        </channel>
                        <input type='mouse' bus='ps2'/>
                        <input type='keyboard' bus='ps2'/>
                        <input type='evdev'>
                          <source dev='${virt.input.mouse}'/>
                        </input>
                        <input type='evdev'>
                          <source dev='${virt.input.keyboard}' grab='all' grabToggle='shift-shift' repeat='on'/>
                        </input>
                        <graphics type='spice' port='-1' autoport='no'>
                          <listen type='address'/>
                          <image compression='off'/>
                        </graphics>
                        <sound model='ich9'>
                          <codec type='micro'/>
                          <audio id='1'/>
                          <address type='pci' domain='0x0000' bus='0x00' slot='0x1b' function='0x0'/>
                        </sound>
                        <audio id='1' type='pulseaudio' serverName='/run/user/1000/pulse/native'/>
                        <video>
                          <model type='none'/>
                        </video>
                        ${ lib.concatStringsSep "\n" (map (cdev: ''
                         <hostdev mode='subsystem' type='pci' managed='yes'>
                           <source>
                             <address domain='0x0000' bus='0x${cdev.address}' slot='0x00' function='0x${cdev.subaddress}'/>
                           </source>
                           <address type='pci' domain='0x0000' bus='0x${cdev.virtaddress}' slot='0x00' function='0x0'/>
                         </hostdev>
                        '') virt.passthrough.devices)}
                        
                        <redirdev bus='usb' type='spicevmc'>
                          <address type='usb' bus='0' port='1'/>
                        </redirdev>
                        <redirdev bus='usb' type='spicevmc'>
                          <address type='usb' bus='0' port='2'/>
                        </redirdev>
                        <watchdog model='itco' action='reset'/>
                        <memballoon model='virtio'>
                          <address type='pci' domain='0x0000' bus='0x04' slot='0x00' function='0x0'/>
                        </memballoon>
                        <shmem name='looking-glass'>
                          <model type='ivshmem-plain'/>
                          <size unit='M'>128</size>
                          <address type='pci' domain='0x0000' bus='0x10' slot='0x01' function='0x0'/>
                        </shmem>
                      </devices>
                    </domain>
                    '') cfg.virtualmachines)
                    }
                    EOM
                ''}";
          RemainAfterExit = true;
        };
      };
    ##################
    ##################
    ##################

    virtualisation = {
      docker.enable = true;
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };

    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      virt-manager
      qemu
      looking-glass-client
    ];

    boot = {
      kernelParams = mkMerge [
        [
          "iommu=pt"
          "pcie_acs_override=downstream,multifunction" 
          "kvm.ignore_msrs=1" 
          "vfio-pci.ids=${builtins.concatStringsSep "," cfg.vfioids}"
        ]
        (mkIf cfg.amd.enable ["amd_iommu=on"]) 
        (mkIf cfg.intel.enable ["intel_iommu=on"])
      ];

      kernelModules = mkMerge [ 
        (mkIf cfg.amd.enable ["kvm-amd"]) 
        (mkIf cfg.intel.enable ["kvm-intel"]) 
      ];
    };
  };
}
