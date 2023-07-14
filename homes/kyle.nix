{config, pkgs, inputs, ...}: let 
  settings = (import ../settings.nix); 
in rec {
  home.username = "kyle";
  home.homeDirectory = "/home/kyle";

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  imports = [];

  stylix.image = settings.style.wallpaper;
  stylix.polarity = "dark";
  stylix.targets.gtk.enable = true;
  stylix.targets.vscode.enable = true;
  stylix.targets.kitty.enable = true;
  stylix.targets.kde.enable = true;
  stylix.opacity.terminal = 0.75;
  stylix.opacity.applications = 0.75;
  stylix.fonts.sizes.applications = 10;
  stylix.targets.waybar = {
    enable = true;
    enableCenterBackColors = true;
    enableLeftBackColors = true;
    enableRightBackColors = true;
  };

  home.file = {
	".config/qt5ct/colors/oomox-current.conf".source = config.lib.stylix.colors {
	        template = builtins.readFile ../desktop/theme/autowallpaper/qt-oomox.conf.mustache;
	        extension = ".conf";
	      };
    ".config/Trolltech.conf".source = config.lib.stylix.colors {
	        template = builtins.readFile ../desktop/theme/autowallpaper/qt.conf.mustache;
	        extension = ".conf";
	      };
    ".config/kdeglobals".source = config.lib.stylix.colors {
	        template = builtins.readFile ../desktop/theme/autowallpaper/qt.conf.mustache;
	        extension = "";
	      };
    ".config/qt5ct/qt5ct.conf".text = pkgs.lib.mkBefore (builtins.readFile ../desktop/theme/autowallpaper/qt5ct.conf.mustache);
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME="qt5ct"; # if this doesnt work properly on hyprland you must add env = QT_QPA_PLATFORMTHEME,qt5ct to your hyprland.conf
  };

  home.file.".config/hypr/hyprland.conf".text = ''
    # This is an example Hyprland config file.
    #
    # Refer to the wiki for more information.

    #
    # Please note not all available settings / options are set here.
    # For a full list, see the wiki
    #

    # See https://wiki.hyprland.org/Configuring/Monitors/
    monitor=,preffered,auto,auto
    monitor=HDMI-A-1,highrr,auto,auto


    # See https://wiki.hyprland.org/Configuring/Keywords/ for more

    # Execute your favorite apps at launch
    # exec-once = waybar & hyprpaper & firefox

    # Source a file (multi-file configs)
    # source = ~/.config/hypr/myColors.conf

    # Some default env vars.
    env = XCURSOR_SIZE,24
    env = QT_QPA_PLATFORMTHEME,qt5ct

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =

        follow_mouse = 1

        touchpad {
            natural_scroll = false
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }

    general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 5
        gaps_out = 20
        border_size = ${settings.style.border_size}
        col.active_border = rgba(${config.lib.stylix.colors.base0A-hex}ee) rgba(${config.lib.stylix.colors.base09-hex}ee) 45deg
        col.inactive_border = rgba(${config.lib.stylix.colors.base0D-hex}96)

        layout = dwindle
    }

    decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10
        blur = true
        blur_size = 3
        blur_passes = 2
        blur_new_optimizations = true

        drop_shadow = true
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
    }

    animations {
        enabled = true

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = myBezier, 0.05, 0.9, 0.1, 1.05

        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
    }

    dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true # you probably want this
    }

    master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true
    }

    gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = false
    }

    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
    device:epic-mouse-v1 {
        sensitivity = -0.5
    }

    # Example windowrule v1
    # windowrule = float, ^(kitty)$
    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


    # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    $mainMod = ALT

    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    bind = $mainMod, RETURN, exec, kitty
    bind = $mainMod, C, killactive,
    bind = $mainMod, M, exit,
    bind = $mainMod, SPACE, togglefloating,
    bind = $mainMod, R, exec, wofi --show drun
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
    bindm = $mainMod, mouse:273, resizewindow

    exec = swaybg -i "${settings.style.wallpaperpath}"
    exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
  '';

  services = {
    kdeconnect = {
      enable = true;
    };
  };

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
      userName = "Kyle";
      userEmail = "kyleraykbs@proton.me";
    };
  };
}