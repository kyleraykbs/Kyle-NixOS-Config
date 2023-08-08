{ config, inputs, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.stylix;
in
{
  options.base.stylix = {
    enable = mkEnableOption "Stylix";
  };

  config = mkIf cfg.enable {
    stylix = {
      image = config.base.wallpaper;
      polarity = "dark";
      targets.gtk.enable = true;
      targets.gtk.extraCss = ''
        window.ssd separator:first-child + headerbar:backdrop,  
        window.ssd separator:first-child + headerbar,  
        window.ssd headerbar:first-child:backdrop,  
        window.ssd headerbar:first-child,  
        window.ssd headerbar:last-child:backdrop,  
        window.ssd headerbar:last-child,  
        window.ssd stack headerbar:first-child:backdrop,  
        window.ssd stack headerbar:first-child,  
        window.ssd stack headerbar:last-child:backdrop,  
        window.ssd stack headerbar:last-child,  
        window.ssd decoration,  
        window.ssd headerbar.titlebar {  
          border-radius: 0.0px;  
        }  
        window.ssd headerbar * {  
          margin-top: -100px;  
          color: #000000;  
        }  
        window.ssd headerbar.titlebar,  
        window.ssd headerbar.titlebar button.titlebutton {  
          border: none;  
          font-size: 0;  
          margin: 0;  
          min-height: 0;  
          padding: 0;  
          color: #000000;  
        }
      '';
      targets.vscode.enable = false;
      targets.kitty.enable = true;
      targets.kde.enable = true;
      opacity.terminal = 0.75;
      opacity.applications = 0.75;
      fonts.sizes.applications = 10;
      targets.waybar = {
        enable = true;
        enableCenterBackColors = true;
        enableLeftBackColors = true;
        enableRightBackColors = true;
      };
    };

    home.file = {
      ".config/qt5ct/colors/oomox-current.conf".source = config.lib.stylix.colors {
            template = builtins.readFile ./mustache/qt-oomox.conf.mustache;
            extension = ".conf";
          };
      ".config/Trolltech.conf".source = config.lib.stylix.colors {
            template = builtins.readFile ./mustache/qt.conf.mustache;
            extension = ".conf";
          };
      ".config/kdeglobals".source = config.lib.stylix.colors {
            template = builtins.readFile ./mustache/qt.conf.mustache;
            extension = ""; 
          };

      ".cache/wal/colors.json".source = config.lib.stylix.colors {
            template = builtins.readFile ./mustache/colors.json.mustache;
            extension = ""; 
          };
      
      ".config/Vencord/settings/quickCss.css".source = config.lib.stylix.colors {
            template = builtins.readFile ./mustache/quickCss.css.mustache;
            extension = ""; 
          };

      ".config/qt5ct/qt5ct.conf".text = pkgs.lib.mkBefore (builtins.readFile ./mustache/qt5ct.conf.mustache);
    };
  };
}