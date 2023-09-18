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
    libsForQt5.qtstyleplugins
    libsForQt5.kdenlive
    swaybg
    pavucontrol
    helvum
    comma
    git-lfs
  ];

  base.thunar.enable = true;
  base.kdeconnect.enable = true;
  base.discord.enable = true;
  base.fish.enable = true;

  base.waybar = {
    enable = true;

    middleModules = [ "clock" ];
    rightModules = [
      "network"
      "memory"
      "temperature"
      "cpu"
      "pulseaudio"
      "tray"
    ];

    clock = {
      use24HourTime = false;
      showSeconds = true;
    };
  };


  base.hyprland.config.dwindle = {
    no_gaps_when_only = true;
  };
  base.hyprland.enable = true;
  base.hyprland.startupApps = [
    {command="virt-manager"; workspace=5; time=1;}
    {command="discord"; workspace=1; time=1;}
  ];
  base.hyprland.extraConfig = ''
    monitor=HDMI-A-1, 3840x2160@60, 0x0, 2
    monitor=DP-2, 3840x2160@60, 0x0, 2

    workspace = 1, monitor:DP-2, default:true
    workspace = 2, monitor:DP-2, default:false
    workspace = 3, monitor:DP-2, default:false
    workspace = 4, monitor:DP-2, default:true
    workspace = 5, monitor:DP-2, default:false
    workspace = 6, monitor:DP-2, default:false
    workspace = 7, monitor:DP-2, default:true
    workspace = 8, monitor:DP-2, default:false
    workspace = 9, monitor:DP-2, default:false

    bind = $mainMod, ESCAPE, exec, kitty sh -c "cd /etc/nixos; git pull; sudo nixos-rebuild switch; hyprctl reload; echo; echo 'Press enter to exit'; read"
  '';

  base.hyprland.config.screenshare.stopkeybind = "ALT SHIFT, A";

  base.hyprland.config.binds = ''
          # See https://wiki.hyprland.org/Configuring/Keywords/ for more
          $mainMod = CTRL SHIFT
          bind = $mainMod, RETURN, exec, kitty
          bind = $mainMod, X, killactive,
          bind = $mainMod, M, exit,
          bind = $mainMod, SPACE, togglefloating,
          bind = $mainMod, R, exec, ulauncher-toggle
          bind = $mainMod, F, fullscreen, # dwindle
          bind = $mainMod, J, togglesplit, # dwindle

          # Move focus with mainMod + arrow keys
          bind = $mainMod, left, movefocus, l
          bind = $mainMod, right, movefocus, r
          bind = $mainMod, up, movefocus, u
          bind = $mainMod, down, movefocus, d

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
          bind = ALT SHIFT, 1, movetoworkspace, 1
          bind = ALT SHIFT, 2, movetoworkspace, 2
          bind = ALT SHIFT, 3, movetoworkspace, 3
          bind = ALT SHIFT, 4, movetoworkspace, 4
          bind = ALT SHIFT, 5, movetoworkspace, 5
          bind = ALT SHIFT, 6, movetoworkspace, 6
          bind = ALT SHIFT, 7, movetoworkspace, 7
          bind = ALT SHIFT, 8, movetoworkspace, 8
          bind = ALT SHIFT, 9, movetoworkspace, 9
          bind = ALT SHIFT, 0, movetoworkspace, 10

          # Scroll through existing workspaces with mainMod + scroll
          bind = $mainMod, mouse_down, workspace, e+1
          bind = $mainMod, mouse_up, workspace, e-1

          # Move/resize windows with mainMod + LMB/RMB and dragging
          bindm = $mainMod, mouse:272, movewindow
          bindm = $mainMod, mouse:273, resizewindow
  '';

  services = {
    dunst = {
      enable = true;
      settings = {
        global = {
          origin = "top-left";
        };
      };
    };
  };

  programs = {
    firefox = {
      enable = true;
    };

    vscode = {
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
      userName = "George";
      userEmail = "gewolf205140@yahoo.com";
    };
  };
}