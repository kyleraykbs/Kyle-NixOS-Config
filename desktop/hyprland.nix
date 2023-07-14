{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wofi
    wl-clipboard
    vaapiVdpau
    slurp
    polkit_gnome
    wlr-randr
  ];

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };

  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    # QT_QPA_PLATFORM = "wayland";
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    # __GL_GSYNC_ALLOWED = "0";
    # __GL_VRR_ALLOWED = "0";
  };

  programs.hyprland = {
    enable = true;

    xwayland = {
      enable = true;
      # hidpi = false;
    };

    # nvidiaPatches = false;
  };

  xdg.portal = {
    enable = true;
    # extraPortals = with pkgs; [
    #   xdg-desktop-portal-wlr
    # ];
    # wlr = {
    #   enable = true;
    #   settings = {
    #     screencast = {
    #       # output_name = "DP-69";
    #       # max_fps = 30;
    #       chooser_type = "simple";
    #       chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
    #     };
    #   };
    # };
  };
}
