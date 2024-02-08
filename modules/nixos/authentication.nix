{ config, lib, pkgs, ... }:
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

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      enableBrowserSocket = true;
      enableExtraSocket = true;
      pinentryFlavor = "gnome3";
    };
    programs.ssh.startAgent = false;

    services.openssh = {
      # enable = true;
      # require public key authentication for better security
      #settings.PasswordAuthentication = false;
      #settings.KbdInteractiveAuthentication = false;
      #settings.PermitRootLogin = "yes";
    };
  };
}
