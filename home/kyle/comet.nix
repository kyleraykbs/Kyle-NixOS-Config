{config, pkgs, inputs, ...}: {
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
    libreoffice
  ];

  base.thunar.enable = true;
  base.kdeconnect.enable = true;
  base.discord.enable = true;
  base.fish.enable = true;

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
      {adapter="DP-1"; resolution="1920x1080"; framerate=60; position="0x0";}
      {adapter="DP-2"; resolution="maxrr"; framerate=200; position="1920x0";}
      {adapter="HDMI-A-1"; resolution="1920x1080"; framerate=60; position="3840x0";}
      {adapter="DVI-D-1"; resolution="1280x1024"; framerate=60; position="5760x0"; transform=1;}
    ];
    workspaces = {
      mouseBased = true;
    };
    #defaultMonitor = {resolution="default"; mirroring="DVI-D-2";};
  };
  base.hyprland.extraConfig = ''
    ## REGULAR
    workspace = 1, monitor:DP-2, default:true
    workspace = 2, monitor:DP-2, default:false
    workspace = 3, monitor:DP-2, default:false

    workspace = 4, monitor:HDMI-A-1, default:true
    workspace = 5, monitor:HDMI-A-1, default:false
    workspace = 6, monitor:DVI-D-1, default:false

    workspace = 7, monitor:HDMI-A-1, default:true
    workspace = 8, monitor:HDMI-A-1, default:false
    workspace = 9, monitor:HDMI-A-1, default:false

    bind = $mainMod, ESCAPE, exec, kitty sh -c "sudo nixos-rebuild switch; hyprctl reload; echo; echo 'Press enter to exit'; read"

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

    vscode = {
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
