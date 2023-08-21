{
  imports = [
    ../../roles/server.nix

    ./hardware.nix
    ./storage.nix
  ];

  networking.hostName = "borealis";
  
  base.user.kyle.enable = true;
  
  services = {
    openssh = {
      enable = true;
      ports = [27069];
    };
  };
}
