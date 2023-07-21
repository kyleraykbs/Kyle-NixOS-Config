{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wofi
    wl-clipboard
    vaapiVdpau
    slurp
    polkit_gnome
    wlr-randr
  ];

  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    # QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
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
    extraPortals = with pkgs; [
      # xdg-desktop-portal-wlr
      # xdg-desktop-portal-kde
    ];
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
