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
      image = config.shared.style.wallpaper;
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

    base.ulauncher.theme = lib.mkDefault "base16";
    
    home.packages = with pkgs; [
      qt5ct
      qt6ct
    ];

    home.file = {
      ".config/qt5ct/colors/oomox-current.conf".source = config.lib.stylix.colors {
            template = builtins.readFile ./mustache/qt-oomox.conf.mustache;
            extension = ".conf";
          };
      ".config/qt6ct/colors/oomox-current-6.conf".source = config.lib.stylix.colors {
            template = builtins.readFile ./mustache/qt-oomox-6.conf.mustache;
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
            template = builtins.readFile ./mustache/colors.json-pywal.mustache;
            extension = ""; 
          };

      ".cache/wal/colors".source = config.lib.stylix.colors {
            template = builtins.readFile ./mustache/colors-pywal.mustache;
            extension = ""; 
          };
      
      ".config/Vencord/settings/quickCss.css".source = config.lib.stylix.colors {
            template = builtins.readFile ./mustache/quickCss.css.mustache;
            extension = ""; 
          };

      ".config/obsidian/TemplateThemesNix/base16/theme.css".source = config.lib.stylix.colors {
            template = builtins.readFile ./mustache/obsidian.css.mustache;
            extension = ""; 
          };
      
       ".config/obsidian/TemplateThemesNix/base16/manifest.json".text = ''
        {
          "name": "Stylix",
          "version": "1.3.2",
          "minAppVersion": "0.16.0",
          "author": "Someone",
          "authorUrl": "https://amongus.sus/"
        }
       '';

      ".config/qt5ct/qt5ct.conf".text = pkgs.lib.mkBefore (builtins.readFile ./mustache/qt5ct.conf.mustache);
      ".config/qt6ct/qt6ct.conf".text = pkgs.lib.mkBefore (builtins.readFile ./mustache/qt6ct.conf.mustache);

      # ULauncher
      ".config/ulauncher/user-themes/stylix-ulauncher/reset.css".source = config.lib.stylix.colors {
            template = builtins.readFile ./mustache/ulauncher/reset.mustache;
            extension = ""; 
          };
      ".config/ulauncher/user-themes/stylix-ulauncher/manifest.json".source = config.lib.stylix.colors {
            template = builtins.readFile ./mustache/ulauncher/manifest.mustache;
            extension = ""; 
          };
       ".config/ulauncher/user-themes/stylix-ulauncher/theme-gtk-3.20.css".source = config.lib.stylix.colors {
            template = builtins.readFile ./mustache/ulauncher/theme-gtk-3.20.mustache;
            extension = ""; 
          };
        ".config/ulauncher/user-themes/stylix-ulauncher/theme.css".source = config.lib.stylix.colors {
            template = builtins.readFile ./mustache/ulauncher/theme.mustache;
            extension = ""; 
          };
      ".config/ulauncher/user-themes/stylix-ulauncher/config.yaml".text = pkgs.lib.mkBefore (builtins.readFile ./mustache/ulauncher/config.yaml);
    };
  };
}
