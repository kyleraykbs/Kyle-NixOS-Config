{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  
  isHidpi = config.base.hidpi.enable;

  cfg = config.base.hyprland;
in
{
  options.base.hyprland = {
    enable = mkEnableOption "Hyprland Home";

    extraConfig = mkOption {
      type = types.str;
      default = "";
    };



    config = {
      general = {
        border_size = mkOption {
          type = types.int;
          default = 3; 
        };

        border_color_1 = mkOption {
          type = types.str;
          default = config.lib.stylix.colors.base0A-hex or "ffffff";
        };

        border_color_2 = mkOption {
          type = types.str;
          default = config.lib.stylix.colors.base08-hex or "ffffff";
        };

        gaps_in = mkOption {
          type = types.int;
          default = 5;
        };
        gaps_out = mkOption {
          type = types.int;
          default = 20;
        };
        layout = mkOption {
          type = types.str;
          default = "dwindle";
        };
      };

      anims = mkOption {
        type = types.str;
        default = ''
          enabled = true

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
        '';
      };

      dwindle = {
        pseudotile = mkOption {
          type = types.bool;
          default = true;
        };
        preserve_split = mkOption {
          type = types.bool;
          default = true;
        };
        no_gaps_when_only = mkOption {
          type = types.bool;
          default = false;
        };
      };

      screenshot = {
        keybind = mkOption {
          type = types.str;
          default = "$mainMod, S";
        };

        output_path = mkOption {
          type = types.str;
          default = "~/Documents/Pictures/Screenshots";
        };
      };

      screenshare = {
        enable = mkOption {
          type = types.bool;
          default = true;
        };

        keybind = mkOption {
          type = types.str;
          default = "$mainMod, A";
        };
      };

      binds = mkOption {
        type = types.str;
        default = ''
          # See https://wiki.hyprland.org/Configuring/Keywords/ for more
          $mainMod = ALT
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
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wofi
      wl-clipboard
      vaapiVdpau
      slurp
      polkit_gnome
      wlr-randr
      grim
      (mkIf cfg.config.screenshare.enable jellyfin-ffmpeg)
      (mkIf cfg.config.screenshare.enable killall)
    ];

    programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
      wlrobs
    ];
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

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      # exec-once = waybar & hyprpaper & firefox

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.
      env = XCURSOR_SIZE,24
      env = _JAVA_AWT_WM_NONREPARENTING,1
      env = QT_QPA_PLATFORMTHEME,qt5ct
      env = LIBSEAT_BACKEND,logind
      env = LIBVA_DRIVER_NAME,nvidia
      env = XDG_SESSION_TYPE,wayland
      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_DESKTOP,Hyprland
      env = GBM_BACKEND,nvidia-drm
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia
      env = WLR_NO_HARDWARE_CURSORS,1
      env = __GL_VRR_ALLOWED,0
      env = GDK_BACKEND,wayland
      env = QT_AUTO_SCREEN_SCALE_FACTOR,1
      env = QT_QPA_PLATFORM,wayland;xcb
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = MOZ_ENABLE_WAYLAND,1

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1
          sensitivity = -0.3
          repeat_rate = 50

          touchpad {
              natural_scroll = false
          }
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = ${builtins.toString cfg.config.general.gaps_in}
          gaps_out = ${builtins.toString cfg.config.general.gaps_out}
          border_size = ${builtins.toString cfg.config.general.border_size}
          col.active_border = rgba(${cfg.config.general.border_color_1}ee) rgba(${cfg.config.general.border_color_2}ee) 45deg
          col.inactive_border = rgba(595959aa)

          layout = ${cfg.config.general.layout}
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 4
          blur = true
          blur_size = 5
          blur_passes = 3
          blur_new_optimizations = true
          inactive_opacity = 0.85
          active_opacity = 0.9

          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
        $(cfg.config.anims)
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = ${builtins.toString cfg.config.dwindle.pseudotile}
          preserve_split = ${builtins.toString cfg.config.dwindle.preserve_split}
          no_gaps_when_only = ${builtins.toString cfg.config.dwindle.no_gaps_when_only}
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

      ${cfg.config.binds}

      ${(if cfg.config.screenshare.enable then ''bind = ${cfg.config.screenshare.keybind},exec,killall -9 ffplay; ffplay /dev/$(ls /dev/ | grep "video" | tail -1)'' else "")}
      bind = ${cfg.config.screenshot.keybind},exec,slurp | grim -g - ${cfg.config.screenshot.output_path}/$(date +'screenshot_%Y-%m-%d-%H%M%S.png'); wl-copy < ${cfg.config.screenshot.output_path}/$(ls ${cfg.config.screenshot.output_path}/ -tp | head -1)

      ### kitty
      windowrule = animation popin,^(kitty)$ # sets the animation style for kitty
      windowrule = float,^(kitty)$
      windowrule = size 50% 50%,^(kitty)$
      windowrule = move cursor -50% -50%,^(kitty)$ # moves kitty to the center of the cursor
      #########

      ${(if cfg.config.screenshare.enable then ''
      ### ffplay
      windowrule = animation popin,^(ffplay)$
      windowrule = float,^(ffplay)$
      windowrule = size 100% 100%,^(ffplay)$
      windowrule = move 13% 100%,^(ffplay)$
      # windowrule = monitor 2,^(ffplay)$
      windowrule = pin,^(ffplay)$
      windowrule = noborder,^(ffplay)$
      #########
      '' else "")}

      ## opacity ##
      windowrule=opacity 0.9 override 0.85 override,^(code-url-handler)$
      windowrule=opacity 0.9,^(pcmanfm)$
      windowrule=opacity 0.925,^(rofi)$
      windowrule=opacity 0.925,^(lutris)$
      windowrule=opacity 0.925,^(org.rncbc.qpwgraph)$
      windowrule=opacity 0.925,^(file-roller)$
      windowrule=opacity 0.925,^(filezilla)$
      windowrule=opacity 0.925,^(Bless)$
      #############

      exec = swaybg -i "${config.base.wallpaper}"
      exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
      exec-once = ${pkgs.libsForQt5.kdeconnect-kde}/libexec/kdeconnectd
      ${cfg.extraConfig}
    '';
  };
}