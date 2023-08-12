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