{config, pkgs, inputs, ...}: {
  home.stateVersion = "23.05";

  gtk = {
    enable = true;
    iconTheme.name = "Qogir";
    cursorTheme.name = "Qogir";
  };

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
    keepassxc
    qt5ct
    qt6ct
    libsForQt5.qtstyleplugins
    libsForQt5.kdenlive
    swaybg
    pavucontrol
    helvum
    comma
    git-lfs
    mate.engrampa
  ];

  base.stylix.enable = true;

  base.hyprland.enable = true;
  base.hyprland.extraConfig = ''
    monitor=DP-2, highres, 0x0, 2

    workspace = 1, monitor:DP-2, default:true
    workspace = 2, monitor:DP-2, default:false
    workspace = 3, monitor:DP-2, default:false
    workspace = 4, monitor:DP-2, default:true
    workspace = 5, monitor:DP-2, default:false
    workspace = 6, monitor:DP-2, default:false
    workspace = 7, monitor:DP-2, default:true
    workspace = 8, monitor:DP-2, default:false
    workspace = 9, monitor:DP-2, default:false
  '';

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
      userName = "George";
      userEmail = "gewolf205140@yahoo.com";
    };
  };
}