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

    startupApps = mkOption {
      type = types.listOf types.attrs;
      default = [
        # TEMPLATE OPTIONS
        # {command="kitty"; workspace=2;}
        # {command="firefox"; workspace=3; time=3;}
      ];
    };

    config = {
      general = {
        border_size = mkOption {
          type = types.int;
          default = 3; 
        };

        border_color_1 = mkOption {
          type = types.str;
          default = config.lib.stylix.colors.base02-hex or "ffffff";
        };

        border_color_2 = mkOption {
          type = types.str;
          default = config.lib.stylix.colors.base04-hex or "ffffff";
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

        rounding = mkOption {
          type = types.int;
          default = 0;
        };

        blur = mkOption {
            type = types.bool;
            default = true;
        };

        active_opacity = mkOption {
            type = types.float;
            default = 0.9;
        };

        inactive_opacity = mkOption {
            type = types.float;
            default = 0.9;
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

      debug = {
        damage_tracking = mkOption {
          type = types.bool;
          default = true;
        };
        logging = mkOption {
          type = types.bool;
          default = false;
        };
      };

      performance = {
          vfr = mkOption {
            type = types.bool;
            default = false;
          };
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
          default = "~/Documents/Media/Pictures/Screenshots";
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

        stopkeybind = mkOption {
          type = types.str;
          default = "$mainMod SHIFT, A";
        };

        obskeybind = mkOption {
          type = types.str;
          default = "$mainMod, o";
        };
      };

      ocr = {
	  enable = mkOption {
	    type = types.bool;
	    default = true;
	  };

	  keybind = mkOption {
	    type = types.str;
            default = "$mainMod, x";
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
          bind = $mainMod, R, exec, ${if config.base.rofi.enable then "rofi -show drun -theme .config/rofi/main.rasi" else "ulauncher-toggle"}
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
      wl-clipboard
      vaapiVdpau
      slurp
      polkit_gnome
      wlr-randr
      grim
      wl-clip-persist
      swaybg
      (mkIf cfg.config.screenshare.enable jellyfin-ffmpeg)
      (mkIf cfg.config.screenshare.enable killall)
      (mkIf cfg.config.screenshare.enable wf-recorder)
      (mkIf cfg.config.ocr.enable tesseract)
    ];

    base.rofi.enable = lib.mkDefault true;

    # set some nice defaults for apps that pair well
    services.dunst.settings.global.frame_width = lib.mkDefault (builtins.floor (cfg.config.general.border_size / 1.5));
    services.dunst.settings.global.corner_radius = lib.mkDefault (builtins.floor (cfg.config.general.rounding * 1.5));
    
    programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-nvfbc
    ];
    home.file.".config/hypr/hyprland.conf".text = ''
      # This is an example Hyprland config file.
      #
      # Refer to the wiki for more information.

      #
      # Please note not all available settings / options are set here.
      # For a full list, see the wiki

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      # exec-once = waybar & hyprpaper & firefox

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.
      env = NIXOS_OZONE_WL,1
      env = XCURSOR_SIZE,24
      env = _JAVA_AWT_WM_NONREPARENTING,1
      env = QT_QPA_PLATFORMTHEME,qt5ct
      env = LIBSEAT_BACKEND,logind
      env = XDG_SESSION_TYPE,wayland
      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_DESKTOP,Hyprland
      env = __GL_VRR_ALLOWED,0
      env = GDK_BACKEND,wayland
      env = QT_AUTO_SCREEN_SCALE_FACTOR,1
      env = QT_QPA_PLATFORM,wayland;xcb
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = MOZ_ENABLE_WAYLAND,1

      ${let
	  lines = builtins.concatStringsSep "\n" (map (x:
	    let
	      resolutionPart = if x ? resolution then
	        if x.resolution == "default" then
	          "preferred"
	        else if x.resolution == "maxres" then
	          "highres"
	        else if x.resolution == "maxrr" then
	          "highrr"
	        else
	          "${x.resolution}@${if x ? framerate then builtins.toString x.framerate else "60"}"
	      else
	        "preferred";
	      positionPart = if x ? position then x.position else "auto";
	      scalePart = if x ? scale then builtins.toString x.scale else "1";
	    in
	    "monitor=${x.adapter},${resolutionPart},${positionPart},${scalePart}${if x ? transform then ",transform,${builtins.toString x.transform}" else ""}${if x ? mirroring then ",mirror,${x.mirroring}" else ""}"
	  ) config.base.monitors.monitors);
	in
	lines
	}

      ${let x = config.base.monitors.defaultMonitor; in
            let
              resolutionPart = if x ? resolution then
                if x.resolution == "default" then
                  "preferred"
                else if x.resolution == "maxres" then
                  "highres"
                else if x.resolution == "maxrr" then
                  "highrr"
                else
                  "${x.resolution}@${if x ? framerate then builtins.toString x.framerate else "60"}"
              else
                "preferred";
              positionPart = if x ? position then x.position else "auto";
              scalePart = if x ? scale then builtins.toString x.scale else "1";
            in
            "monitor=,${resolutionPart},${positionPart},${scalePart}${if x ? transform then ",transform,${builtins.toString x.transform}" else ""}${if x ? mirroring then ",mirror,${x.mirroring}" else ""}"
	}

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
      	      disable_while_typing = false
          }
      }

      xwayland {
        force_zero_scaling = true
      }

      misc {
          vfr = ${if cfg.config.performance.vfr then "true" else "false"}
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = ${builtins.toString cfg.config.general.gaps_in}
          gaps_out = ${builtins.toString cfg.config.general.gaps_out}
          border_size = ${builtins.toString cfg.config.general.border_size}
          col.active_border = rgba(${cfg.config.general.border_color_1}ee) rgba(${cfg.config.general.border_color_2}ee) 45deg
          col.inactive_border = rgba(595959aa)
          allow_tearing = true

          layout = ${cfg.config.general.layout}
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = ${builtins.toString cfg.config.general.rounding}
          blur {
              enabled = ${if cfg.config.general.blur then "true" else "false"}
          }
          inactive_opacity = ${builtins.toString cfg.config.general.inactive_opacity}
          active_opacity = ${builtins.toString cfg.config.general.active_opacity}

          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      layerrule = blur,rofi

      animations {
        ${cfg.config.anims}
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = ${(if cfg.config.dwindle.pseudotile then "true" else "false")}
          preserve_split = ${(if cfg.config.dwindle.preserve_split then "true" else "false")}
          no_gaps_when_only = ${(if cfg.config.dwindle.no_gaps_when_only then "true" else "false")}
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

      debug {
        damage_tracking = ${builtins.toString (if cfg.config.debug.damage_tracking then 2 else 1)}
        disable_logs = ${builtins.toString (if cfg.config.debug.logging then "false" else "true")}
        damage_blink = false
      }

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      ${cfg.config.binds}

      ${(if cfg.config.screenshare.enable then ''bind = ${cfg.config.screenshare.keybind},exec,killall -9 wf-recorder; killall -9 ffplay; hyprctl keyword debug:damage_tracking 0; wf-recorder -f pipe:99 -m matroska -g "$(slurp -o)" -r 30 -b:v 2M -c libx264 99>&1 >&2 | ffplay -probesize 32 -sync ext -fflags nobuffer -vcodec h264 -'' else "")}
      ${(if cfg.config.screenshare.enable then ''bind = ${cfg.config.screenshare.stopkeybind},exec,killall -9 wf-recorder; killall -9 ffplay; hyprctl keyword debug:damage_tracking ${builtins.toString (if cfg.config.debug.damage_tracking then 2 else 1)}'' else "")}
      ${(if cfg.config.screenshare.enable then ''bind = ${cfg.config.screenshare.obskeybind},exec,killall -9 ffplay; ffplay /dev/video0'' else "")}
      bind = ${cfg.config.screenshot.keybind},exec,slurp | grim -g - ${cfg.config.screenshot.output_path}/$(date +'screenshot_%Y-%m-%d-%H%M%S.png'); wl-copy < ${cfg.config.screenshot.output_path}/$(ls ${cfg.config.screenshot.output_path}/ -tp | head -1)

      ${if cfg.config.ocr.enable then ''bind = ${cfg.config.ocr.keybind},exec,hyprctl dispatch toggleopaque; slurp | grim -g - ocr.png; hyprctl dispatch toggleopaque; tesseract ocr.png ocr -l eng --oem 1; cat ocr.txt | wl-copy; rm ocr.txt ocr.png'' else ""}

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
      windowrule = size 1920 1080,^(ffplay)$
      windowrule = move 0% 100%,^(ffplay)$
      # windowrule = monitor 2,^(ffplay)$
      windowrule = pin,^(ffplay)$
      windowrule = noborder,^(ffplay)$
      #########
      '' else "")}

      ### ulauncher
      windowrule = float,^(ulauncher)$
      windowrule = pin,^(ulauncher)$
      windowrule = noborder,^(ulauncher)$
      #########

      ${if config.base.waybar.enable then "exec-once=sleep 4; waybar" else ""}
      ${if config.base.ulauncher.enable then "exec-once=fish -c 'while true;ulauncher --hide-window --no-window-shadow;end;'" else ""}
      exec = killall -9 swaybg; swaybg --mode fill -i "${config.base.wallpaper}"
      exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
      exec-once = ${pkgs.libsForQt5.kdeconnect-kde}/libexec/kdeconnectd
      exec-once = hyprctl dispatch workspace 1
      exec-once = hyprctl setcursor Qogir 24
      exec-once = xdg-user-dirs-update
      exec-once = wl-clip-persist --clipboard regular
      ${cfg.extraConfig}

      exec-once=${
        let
          lines = builtins.concatStringsSep  "; " (map (
            x: 
            let
              timePart = if x ? time then builtins.toString x.time else "1";
            in
            (x.command + " & sleep ${timePart}; hyprctl dispatch movetoworkspacesilent " + (builtins.toString x.workspace))
            ) cfg.startupApps);
        in
        lines
      }
    '';
  };
}
