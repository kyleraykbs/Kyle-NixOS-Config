{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.authentication;
in
{
  options.base.authentication = {
    enable = mkEnableOption "Enable Authentication features";
  };

  config = mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;
    security.pam.services.sddm.enableGnomeKeyring = true;
    programs.ssh.startAgent = true;

    services.openssh = {
      enable = true;
      # require public key authentication for better security
      #settings.PasswordAuthentication = false;
      #settings.KbdInteractiveAuthentication = false;
      #settings.PermitRootLogin = "yes";
    };
  };
}
