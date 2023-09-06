{pkgs, ...}: {
  imports = [
    ../../roles/server.nix

    ./hardware.nix
    ./storage.nix
  ];

  networking.hostName = "borealis";
  
  base.user.kyle.enable = true;
  base.user.jon.enable = true;

  services.vsftpd = {
    enable = true;
    writeEnable = true;
    localUsers = true;
    userlist = [ "kyle" ];
    userlistEnable = true;
  };
  
  services = {
    openssh = {
      enable = true;
      ports = [27069];
    };
  };
}
