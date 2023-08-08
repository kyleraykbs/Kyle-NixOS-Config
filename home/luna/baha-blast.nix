{config, pkgs, inputs, ...}: {
  home.stateVersion = "23.05";

  gtk = {
    enable = true;
    iconTheme.name = "Qogir";
    cursorTheme.name = "Qogir";
  };

  home.packages = with pkgs; [
    qogir-icon-theme
    quintom-cursor-theme
    authenticator
    clipman
    gimp
    firefox
    github-desktop
    keepassxc
    qt5ct
    qt6ct
    libsForQt5.qtstyleplugins
    libsForQt5.kdenlive
    swaybg
    pavucontrol
    helvum
    comma
    git-lfs
    lf
    ani-cli
    pulsemixer
    prismlauncher
    udiskie
  ];

  base.pcmanfm.enable = true;
  base.kdeconnect.enable = true;
  base.discord.enable = true;

  base.stylix.enable = true;

  base.hyprland.enable = true;
  base.hyprland.extraConfig = ''
    monitor=, highres, 0x0, 1
    exec-once = sudo swapon /var/lib/swapfile # This is an solution. no good not libfakekey
  '';
  base.hyprland.config.anims = ''
    enabled = true

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, loop
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
  '';
  base.hyprland.config.binds = ''
          # See https://wiki.hyprland.org/Configuring/Keywords/ for more
          $mainMod = ALT

          # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
          bind = $mainMod, RETURN, exec, kitty
          bind = $mainMod, C, killactive,
          bind = $mainMod, E, exec, kitty lf
          bind = $mainMod, M, exit,
          bind = $mainMod, v, togglefloating,
          bind = $mainMod, TAB, exec, wofi --show drun
          bind = $mainMod, F, fullscreen, # dwindle
          bind = $mainMod, J, togglesplit, # dwindle
          bind = SUPER, ESCAPE, exec, kitty sudo nixos-rebuild switch
          bind = $mainMod, K, exec, python ~/Documents/Scripts/kyle-count/main.py; kitty cat ~/Documents/Scripts/kyle-count/count.txt

          # Move focus with mainMod + arrow keys
          bind = $mainMod, left, movefocus, l
          bind = $mainMod, right, movefocus, r
          bind = $mainMod, up, movefocus, u
          bind = $mainMod, down, movefocus, d

          # Audio and brightness
          bind = SUPER, right, exec, pulsemixer --change-volume +5
          bind = SUPER, left, exec, pulsemixer --change-volume -5
          bind = SUPER, up, exec, light -A 5
          bind = SUPER, down, exec, light -U 5

          # Switch workspaces with mainMod + [0-9]
          bind = $mainMod, 1, workspace, 1
          bind = $mainMod, 2, workspace, 2
          bind = $mainMod, 3, workspace, 3
          bind = $mainMod, 4, workspace, 4
          bind = $mainMod, 5, workspace, 5
          bind = $mainMod, 6, workspace, 6
          bind = $mainMod, 7, workspace, 7
          bind = $mainMod, 8, workspace, 8
          bind = $mainMod, 9, workspace, 9
          bind = $mainMod, 0, workspace, 10

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          bind = $mainMod SHIFT, 1, movetoworkspace, 1
          bind = $mainMod SHIFT, 2, movetoworkspace, 2
          bind = $mainMod SHIFT, 3, movetoworkspace, 3
          bind = $mainMod SHIFT, 4, movetoworkspace, 4
          bind = $mainMod SHIFT, 5, movetoworkspace, 5
          bind = $mainMod SHIFT, 6, movetoworkspace, 6
          bind = $mainMod SHIFT, 7, movetoworkspace, 7
          bind = $mainMod SHIFT, 8, movetoworkspace, 8
          bind = $mainMod SHIFT, 9, movetoworkspace, 9
          bind = $mainMod SHIFT, 0, movetoworkspace, 10

          # Scroll through existing workspaces with mainMod + scroll
          bind = $mainMod, mouse_down, workspace, e+1
          bind = $mainMod, mouse_up, workspace, e-1

          # Move/resize windows with mainMod + LMB/RMB and dragging
          bindm = $mainMod, mouse:272, movewindow
          bindm = $mainMod, mouse:273, resizewindow
  '';

  programs = {
    firefox = {
      enable = true;
    };

    vscode = {
      enable = true;
    };

    waybar = {
      enable = true;
    };

    kitty = {
      enable = true;
      settings = {
        opacity = "0.5";
        confirm_os_window_close = 0;
      };
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
      ];
    };

    gh = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "Gemstone48";
      userEmail = "mizztree78@gmail.com";
    };
  };
}