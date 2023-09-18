{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    mkMerge
    ;

  cfg = config.base.virtualisation;
in
{
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
            storage = {
              devices = [
                {storagepath="somefile"}
              ];
            }
            cpu = {
              cores = 11
            }
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
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };

    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      virt-manager
      qemu
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
