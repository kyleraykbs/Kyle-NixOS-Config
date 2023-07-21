{config, pkgs, inputs, ...}: let 
  settings = (import ../../settings.nix); 
  systemhome = if (settings.hostname == "comet") then 
                  (import ./cometsettings.nix)
               else if (settings.hostname == "rutabega") then 
                  (import ./rutabegasettings.nix) else {};
in rec {
  home.username = "kyle";
  home.homeDirectory = "/home/kyle";

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    qogir-icon-theme
    quintom-cursor-theme
    authenticator
    clipman
    libsForQt5.kcmutils
    libsForQt5.kirigami-addons
    libsForQt5.kpeoplevcard
    libfakekey
    libsForQt5.modemmanager-qt
    libsForQt5.pulseaudio-qt
    libsForQt5.qca-qt5
    libsForQt5.qqc2-desktop-style
    libsForQt5.qt5.qttools
    libsForQt5.kdeconnect-kde
    gimp
    pcmanfm
    firefox
    discord
    github-desktop
    swww
    keepassxc
    qt5ct
    qt6ct
    libsForQt5.qtstyleplugins
    libsForQt5.kdenlive
    swaybg
    pavucontrol
    helvum
  ];

  gtk = {
    enable = true;
    iconTheme.name = "Qogir";
    cursorTheme.name = "Qogir";
  };


  imports = [];

  stylix = {
    image = settings.style.wallpaper;
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
    targets.vscode.enable = true;
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
	        template = builtins.readFile ../../desktop/theme/autowallpaper/qt-oomox.conf.mustache;
	        extension = ".conf";
	      };
    ".config/Trolltech.conf".source = config.lib.stylix.colors {
	        template = builtins.readFile ../../desktop/theme/autowallpaper/qt.conf.mustache;
	        extension = ".conf";
	      };
    ".config/kdeglobals".source = config.lib.stylix.colors {
	        template = builtins.readFile ../../desktop/theme/autowallpaper/qt.conf.mustache;
	        extension = ""; 
	      };
    ".config/qt5ct/qt5ct.conf".text = pkgs.lib.mkBefore (builtins.readFile ../../desktop/theme/autowallpaper/qt5ct.conf.mustache);
  };
}
