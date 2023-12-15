{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.base.rofi;
in
{
  options.base.rofi = {
    enable = mkEnableOption "rofi";
    theme = {
        colors = {
            background = mkOption {
                type = types.string;
                default = "#1E2127FF";
            };
            background-alt = mkOption {
                type = types.string;
                default = "#282B31FF";
            };
            foreground = mkOption {
                type = types.string;  
                default = "#FFFFFFFF";  
            };
            selected = mkOption {
                type = types.string;  
                default = "#61AFEFFF";  
            };
            active = mkOption {
                type = types.string;  
                default = "#98C379FF";  
            };
            urgent = mkOption {
                type = types.string;  
                default = "#E06C75FF";  
            };
        };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rofi-wayland
    ];
    home.file = {
        ".config/rofi/colors.rasi".text = if config.base.stylix.enable == true then
            with config.lib.stylix.colors; ''
            * {
                background:     #${base00-hex}e6;
                background-alt: #${base03-hex}64;
                foreground:     #${base05-hex}FF;
                selected:       #${base04-hex}FF;
                active:         #98C379FF;
                urgent:         #E06C75FF;
            }
            '' else ''
            * {
                background:     #1E2127FF;
                background-alt: #282B31FF;
                foreground:     #FFFFFFFF;
                selected:       #61AFEFFF;
                active:         #98C379FF;
                urgent:         #E06C75FF;
            }
            '';


        ".config/rofi/main.rasi".text = ''
        /*****----- Configuration -----*****/
configuration {
	modi:                       "drun";
    show-icons:                 true;
    display-drun:               "Applications";
	drun-display-format:        "{name}";
}

/*****----- Global Properties -----*****/

@import                          "colors.rasi"

/*****----- Main Window -----*****/
window {
    transparency:                "real";
    location:                    center;
    anchor:                      center;
    fullscreen:                  false;
    width:                       800px;
    x-offset:                    0px;
    y-offset:                    0px;

    enabled:                     true;
    margin:                      0px;
    padding:                     0px;
    border:                      0px solid;
    border-radius:               0px;
    border-color:                @selected;
    background-color:            @background;
    cursor:                      "default";
}

/*****----- Main Box -----*****/
mainbox {
    enabled:                     true;
    spacing:                     10px;
    margin:                      0px;
    padding:                     30px;
    border:                      0px solid;
    border-radius:               0px 0px 0px 0px;
    border-color:                @selected;
    background-color:            transparent;
    children:                    [ "inputbar", "listview" ];
}

/*****----- Inputbar -----*****/
inputbar {
    enabled:                     true;
    spacing:                     0px;
    margin:                      0px;
    padding:                     0px;
    border:                      0px solid;
    border-radius:               0px;
    border-color:                @selected;
    background-color:            @background-alt;
    text-color:                  @foreground;
    children:                    [ "prompt", "entry" ];
}

prompt {
    enabled:                     true;
    padding:                     12px;
    background-color:            @selected;
    text-color:                  @background;
}
textbox-prompt-colon {
    enabled:                     true;
    expand:                      false;
    str:                         "::";
    background-color:            inherit;
    text-color:                  inherit;
}
entry {
    enabled:                     true;
    padding:                     12px;
    background-color:            inherit;
    text-color:                  inherit;
    cursor:                      text;
    placeholder:                 "Search...";
    placeholder-color:           inherit;
}

/*****----- Listview -----*****/
listview {
    enabled:                     true;
    columns:                     2;
    lines:                       10;
    cycle:                       true;
    dynamic:                     true;
    scrollbar:                   false;
    layout:                      vertical;
    reverse:                     false;
    fixed-height:                true;
    fixed-columns:               true;
    
    spacing:                     10px;
    margin:                      0px;
    padding:                     0px;
    border:                      0px solid;
    border-radius:               0px;
    border-color:                @selected;
    background-color:            transparent;
    text-color:                  @foreground;
    cursor:                      "default";
}
scrollbar {
    handle-width:                5px ;
    handle-color:                @selected;
    border-radius:               0px;
    background-color:            @background-alt;
}

/*****----- Elements -----*****/
element {
    enabled:                     true;
    spacing:                     10px;
    margin:                      0px;
    padding:                     5px;
    border:                      0px solid;
    border-radius:               0px;
    border-color:                @selected;
    background-color:            @background;
    text-color:                  @foreground;
    cursor:                      pointer;
}
element normal.normal {
    background-color:            @background-alt;
    text-color:                  @foreground;
}
element alternate.normal {
    background-color:            @background-alt;
    text-color:                  @foreground;
}
element selected.normal {
    border:                      0px 0px 0px 4px;
    border-color:                @selected;
    background-color:            @background-alt;
    text-color:                  @selected;
}
element-icon {
    padding:                     0px 0px 0px 10px;
    background-color:            transparent;
    text-color:                  inherit;
    size:                        32px;
    cursor:                      inherit;
}
element-text {
    background-color:            transparent;
    text-color:                  inherit;
    highlight:                   inherit;
    cursor:                      inherit;
    vertical-align:              0.5;
    horizontal-align:            0.0;
}

/*****----- Message -----*****/
error-message {
    padding:                     15px;
    border:                      2px solid;
    border-radius:               0px;
    border-color:                @selected;
    background-color:            @background;
    text-color:                  @foreground;
}
textbox {
    background-color:            @background;
    text-color:                  @foreground;
    vertical-align:              0.5;
    horizontal-align:            0.0;
    highlight:                   none;
}

            '';
    };
  };
}
