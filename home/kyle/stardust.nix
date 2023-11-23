{config, pkgs, inputs, ...}: {
  home.stateVersion = "23.05";

  gtk = {
    enable = true;
    iconTheme.name = "Qogir";
    cursorTheme.name = "Qogir";
  };

  base.lutris.enable = true;

  home.packages = with pkgs; [
    arduino
    cemu
    yuzu
    openscad
    prusa-slicer
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
    obsidian
    libreoffice
  ];

  base.neovim = {
    enable = true;
    plugins = {
      nerdtree = {
        enable = true;
      };
      startify = {
        enable = true;
      };
      nerdcommenter = {
        enable = true;
        binds = {
          defaultBinds = true;
        };
      };
      ale = {
        enable = true;
      };
      indentLine = {
        enable = true;
        config = {
          char = "['┆', '│']";
        };
      };
      whichKey = {
        enable = true;
      };
      autoPairs = {
        enable = true;
      };
      whiteSpace = {
        enable = true;
      };
      airLine = {
        enable = true;
      };
      easyMotion = {
        enable = true;
      };
      fugitive = {
        enable = true;
      };
      treeSitter = {
        enable = true;
      };
      devicons = {
        enable = true;
      };
      workSpace = {
        enable = true;
        config = {
          autoSession = true;
        };
      };
      autoSave = {
        enable = true;
        onStart = true;
      };
    };
  };

  base.monitors = {
    monitors = [
      {adapter="eDP-1"; resolution="1600x900"; framerate=60; position="0x0";}
    ];
    defaultMonitor = {resolution="default"; mirroring="eDP-1";};
  };

  base.hyprland.extraConfig = ''
    bind = $mainMod, ESCAPE, exec, kitty sh -c "sudo nixos-rebuild switch; hyprctl reload; echo; echo 'Press enter to exit'; read"
    monitor=eDP-1, 1600x900, auto, 1
    monitor=,highres,auto,1,mirror,eDP-1
  '';

  base.thunar.enable = true;
  base.kdeconnect.enable = true;
  base.discord.enable = true;
  base.direnv.enable = true;
  base.fish.enable = true;

  base.stylix.enable = true;

  base.hyprland.enable = true;  
  base.hyprland.config.binds = ''
    # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    $mainMod = ALT
    bind = $mainMod, RETURN, exec, kitty
    bind = $mainMod, C, killactive,
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
    bindm = , code:133, resizewindow
  '';

  base.waybar = {
    enable = true;

    middleModules = [ "clock" ];
    rightModules = [
      "network"
      "memory"
      "temperature"
      "battery"
      "cpu"
      "pulseaudio"
      "tray"
    ];

    clock = {
      use24HourTime = false;
      showSeconds = true;
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
      userName = "Kyle";
      userEmail = "kyleraykbs@proton.me";
    };
  };
}
