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
  ];

  base.stylix.enable = true;

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
      userName = "Gemstone48";
      userEmail = "mizztree78@gmail.com";
    };
  };
}