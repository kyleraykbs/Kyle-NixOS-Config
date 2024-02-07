{config, pkgs, inputs, lib, ...}: 
let
  inherit (lib)
      mkEnableOption
      mkIf
      mkOption
      types
      ;
in
{
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    pavucontrol
    vlc
    unetbootin
    qogir-icon-theme
    quintom-cursor-theme
    authenticator
    clipman
    gimp
    krita
    firefox
    github-desktop
    keepassxc
    libsForQt5.qtstyleplugins
    libsForQt5.kdenlive
    swaybg
    helvum
    comma
    git-lfs
    obsidian
    signal-desktop
    fritzing
    xvfb-run
    libreoffice
    upnp-router-control
  ];

  base.thunar.enable = true;
  base.feh.enable = true;
  base.kdeconnect.enable = true;
  base.discord.enable = true;
  base.fish.enable = true;
  base.vscode.enable = true;
  base.vlc.enable = true;

  base.neovim = {
    enable = true;
    plugins = {
      nerdtree = {
        enable = true;
      };
      startify = {
        enable = true;
      };
      nerdcommenter = {
        enable = true;
        binds = {
          defaultBinds = true;
        };
      };
      ale = {
        enable = true;
      };
      indentLine = {
        enable = false;
        config = {
          char = "['┆', '│']";
        };
      };
      whichKey = {
        enable = true;
      };
      autoPairs = {
        enable = true;
      };
      whiteSpace = {
        enable = true;
      };
      airLine = {
        enable = true;
      };
      easyMotion = {
        enable = true;
      };
      fugitive = {
        enable = true;
      };
      treeSitter = {
        enable = true;
      };
      devicons = {
        enable = true;
      };
      workSpace = {
        enable = true;
        config = {
          autoSession = true;
        };
      };
      autoSave = {
        enable = true;
        onStart = true;
      };
    };
  };

  # base.waybar.enable = true;
  base.stylix.enable = true;

  base.hyprland.enable = true;
  base.monitors = {
    monitors = [
      #{adapter="HDMI-A-1"; resolution="1920x1080"; framerate=60; position="0x0";}
      {adapter="DP-1"; resolution="1920x1080"; framerate=60; position="1920x0";}
      {adapter="DP-2"; resolution="1920x1080"; framerate=120; position="3840x0";}
      {adapter="DVI-D-1"; resolution="1920x1080"; framerate=60; position="5760x0";}
    ];
    workspaces = {
      displayAssociation = [
        {display="DP-2"; workspaces=[{number=1; default=true;} {number=2; default=false;} {number=3; default=false;}];}
        {display="DVI-D-1"; workspaces=[{number=4; default=true;} {number=5; default=false;} {number=6; default=false;}];}
        {display="DP-1"; workspaces=[{number=7; default=true;} {number=8; default=false;} {number=9; default=false;}];}
      ];
    };
    #defaultMonitor = {resolution="default"; mirroring="DVI-D-2";};
  };
  base.hyprland.extraConfig = ''
    ## REGULAR
    bind = , code:90, workspace, 1
    bind = , code:87, workspace, 1
    bind = , code:88, workspace, 2
    bind = , code:89, workspace, 3
    bind = , code:83, workspace, 4
    bind = , code:84, workspace, 5
    bind = , code:85, workspace, 6
    bind = , code:79, workspace, 7
    bind = , code:80, workspace, 8
    bind = , code:81, workspace, 9
  '';

  services = {
    dunst = {
      enable = true;
      settings = {
        global = {
          monitor = 1;
          origin = "top-left";
        };
      };
    };
  };

  programs = {
    firefox = {
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
        obs-nvfbc
      ];
    };

    gh = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "Kyle";
      userEmail = "kyleraykbs@proton.me";
    };
  };
}
