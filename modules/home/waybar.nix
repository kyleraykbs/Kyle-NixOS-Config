{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.base.waybar;
in
{
  options.base.waybar = {
    enable = mkEnableOption "waybar";

    modules = {
      
    };

    onTopOfScreen = mkOption {
      type = types.bool;
      default = true;
    };

    onTopLayer = mkOption {
      type = types.bool;
      default = true;
    };

    leftModules = mkOption {
      type = types.listOf types.str;
      default = [
        "wlr/workspaces"
      ];
    };

    middleModules = mkOption {
      type = types.listOf types.str;
      default = [
        "hyprland/window" 
      ];
    };

    rightModules = mkOption {
      type = types.listOf types.str;
      default = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "battery" 
        "clock"
        "tray"
      ];
    };

    clock = {
      use24HourTime = mkOption {
        type = types.bool;
        default = false;
      };
      showSeconds = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = {
        enable = true;
        package = mkIf config.base.hyprland.enable (pkgs.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          postPatch = '' 
            # use hyprctl to switch workspaces 
            sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp 
          ''; 
        }));
        style = ''
          * {
            /* `otf-font-awesome` is required to be installed for icons */
            font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
            font-size: 13px;
          }

          window#waybar {
              background-color: rgba(43, 48, 59, 0.5);
              border-bottom: 3px solid rgba(100, 114, 125, 0.5);
              color: #ffffff;
              transition-property: background-color;
              transition-duration: .5s;
          }

          window#waybar.hidden {
              opacity: 0.2;
          }

          /*
          window#waybar.empty {
              background-color: transparent;
          }
          window#waybar.solo {
              background-color: #FFFFFF;
          }
          */

          window#waybar.termite {
              background-color: #3F3F3F;
          }

          window#waybar.chromium {
              background-color: #000000;
              border: none;
          }

          button {
              /* Use box-shadow instead of border so the text isn't offset */
              box-shadow: inset 0 -3px transparent;
              /* Avoid rounded borders under each button name */
              border: none;
              border-radius: 0;
          }

          /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
          button:hover {
              background: inherit;
              box-shadow: inset 0 -3px #ffffff;
          }

          #workspaces button {
              padding: 0 5px;
              background-color: transparent;
              color: #ffffff;
          }

          #workspaces button:hover {
              background: #64FF7D;
          }

          #workspaces button.focused {
              background: #64FF7D;
          }

          .modules-left #workspaces button.active {
              background: #64FF7D;
          }
          .modules-left #workspaces button.urgent {
              background-color: #007000;
          }

          #workspaces button.urgent {
              background: #64FF7D;
          }

          #mode {
              background: #64FF7D;
              background-color: #64727D;
              border-bottom: 3px solid #ffffff;
          }

          #clock,
          #battery,
          #cpu,
          #memory,
          #disk,
          #temperature,
          #backlight,
          #network,
          #pulseaudio,
          #wireplumber,
          #custom-media,
          #tray,
          #mode,
          #idle_inhibitor,
          #scratchpad,
          #mpd {
              padding: 0 10px;
              color: #ffffff;
          }

          #window,
          #workspaces {
              margin: 0 4px;
          }

          /* If workspaces is the leftmost module, omit left margin */
          .modules-left > widget:first-child > #workspaces {
              margin-left: 0;
          }

          /* If workspaces is the rightmost module, omit right margin */
          .modules-right > widget:last-child > #workspaces {
              margin-right: 0;
          }

          #clock {
              background-color: #64727D;
          }

          #battery {
              background-color: #ffffff;
              color: #000000;
          }

          #battery.charging, #battery.plugged {
              color: #ffffff;
              background-color: #26A65B;
          }

          @keyframes blink {
              to {
                  background-color: #ffffff;
                  color: #000000;
              }
          }

          #battery.critical:not(.charging) {
              background-color: #f53c3c;
              color: #ffffff;
              animation-name: blink;
              animation-duration: 0.5s;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction: alternate;
          }

          label:focus {
              background-color: #000000;
          }

          #cpu {
              background-color: #2ecc71;
              color: #000000;
          }

          #memory {
              background-color: #9b59b6;
          }

          #disk {
              background-color: #964B00;
          }

          #backlight {
              background-color: #90b1b1;
          }

          #network {
              background-color: #2980b9;
          }

          #network.disconnected {
              background-color: #f53c3c;
          }

          #pulseaudio {
              background-color: #f1c40f;
              color: #000000;
          }

          #pulseaudio.muted {
              background-color: #90b1b1;
              color: #2a5c45;
          }

          #wireplumber {
              background-color: #fff0f5;
              color: #000000;
          }

          #wireplumber.muted {
              background-color: #f53c3c;
          }

          #custom-media {
              background-color: #66cc99;
              color: #2a5c45;
              min-width: 100px;
          }

          #custom-media.custom-spotify {
              background-color: #66cc99;
          }

          #custom-media.custom-vlc {
              background-color: #ffa000;
          }

          #temperature {
              background-color: #f0932b;
          }

          #temperature.critical {
              background-color: #eb4d4b;
          }

          #tray {
              background-color: #2980b9;
          }

          #tray > .passive {
              -gtk-icon-effect: dim;
          }

          #tray > .needs-attention {
              -gtk-icon-effect: highlight;
              background-color: #eb4d4b;
          }

          #idle_inhibitor {
              background-color: #2d3436;
          }

          #idle_inhibitor.activated {
              background-color: #ecf0f1;
              color: #2d3436;
          }

          #mpd {
              background-color: #66cc99;
              color: #2a5c45;
          }

          #mpd.disconnected {
              background-color: #f53c3c;
          }

          #mpd.stopped {
              background-color: #90b1b1;
          }

          #mpd.paused {
              background-color: #51a37a;
          }

          #language {
              background: #00b093;
              color: #740864;
              padding: 0 5px;
              margin: 0 5px;
              min-width: 16px;
          }

          #keyboard-state {
              background: #97e1ad;
              color: #000000;
              padding: 0 0px;
              margin: 0 5px;
              min-width: 16px;
          }

          #keyboard-state > label {
              padding: 0 5px;
          }

          #keyboard-state > label.locked {
              background: rgba(0, 0, 0, 0.2);
          }

          #scratchpad {
              background: rgba(0, 0, 0, 0.2);
          }

          #scratchpad.empty {
            background-color: transparent;
          }
        '';

        settings = [{
        height = 30;
        layer = (if cfg.onTopLayer then "top" else "bottom");
        position = (if cfg.onTopOfScreen then "top" else "bottom");
        tray = { spacing = 10; };
        
        "wlr/workspaces" = {
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          on-click = "activate";
          sort-by-number = true;
        };
        modules-left = cfg.leftModules;
        modules-center = cfg.middleModules;
        modules-right = cfg.rightModules;
        battery = {
          format = "{capacity}% {icon}";
          format-alt = "{time} {icon}";
          format-charging = "{capacity}% ";
          format-icons = [ "" "" "" "" "" ];
          format-plugged = "{capacity}% ";
          states = {
            critical = 15;
            warning = 30;
          };
        };
        clock = {
          interval = mkIf cfg.clock.showSeconds 1;
          format = "{:${if cfg.clock.use24HourTime then ":%H" else ":%I"}:%M${if cfg.clock.showSeconds then ":%S" else ""} ${if cfg.clock.use24HourTime then "" else "%p"}}";
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        memory = { format = "{}% "; };
        network = {
          interval = 1;
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          format-disconnected = "Disconnected ⚠";
          format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
          format-linked = "{ifname} (No IP) ";
          format-wifi = "{essid} ({signalStrength}%) ";
        };
        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-icons = {
            car = "";
            default = [ "" "" "" ];
            handsfree = "";
            headphones = "";
            headset = "";
            phone = "";
            portable = "";
          };
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          on-click = "pavucontrol";
        };
        "sway/mode" = { format = ''<span style="italic">{}</span>''; };
        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [ "" "" "" ];
        };
      }];
    };
  };
}