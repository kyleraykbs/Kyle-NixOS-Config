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

    hostcpus = mkOption {
        type=types.string;
    };

    virtcpus = mkOption {
        type=types.string;
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

    systemd.services.libvirtd.preStart = ''
        mkdir -p /var/lib/libvirt/hooks
        chmod 755 /var/lib/libvirt/hooks

        cp -f ${pkgs.writeScript "qemu" ''
            #!/run/current-system/sw/bin/bash
            if [[ $2 == "start" || $2 == "stopped" ]]
            then
              if [[ $2 == "start" ]]
              then
                systemctl set-property --runtime -- user.slice AllowedCPUs=${cfg.virtcpus}  
                systemctl set-property --runtime -- system.slice AllowedCPUs=${cfg.virtcpus}  
                systemctl set-property --runtime -- init.scope AllowedCPUs=${cfg.virtcpus}  
              else
                systemctl set-property --runtime -- user.slice AllowedCPUs=${cfg.hostcpus}  
                systemctl set-property --runtime -- system.slice AllowedCPUs=${cfg.hostcpus}  
                systemctl set-property --runtime -- init.scope AllowedCPUs=${cfg.hostcpus}  
              fi
            fi
            ''} /var/lib/libvirt/hooks/qemu

        chmod +x /var/lib/libvirt/hooks/qemu
    '';

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
