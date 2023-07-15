{pkgs, ...}: {
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    virt-manager
    qemu
  ];
}