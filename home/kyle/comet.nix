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
    gimp
    firefox
    github-desktop
    keepassxc
    libsForQt5.qtstyleplugins
    libsForQt5.kdenlive
    swaybg
    pavucontrol
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
        enable = true;
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
  base.hyprland.extraConfig = ''
    # monitor=DP-4, 1920x1080@240, 1920x0, 1
    # monitor=HDMI-A-2, 1920x1080@60, 0x0, 1
    # monitor=HDMI-A-1,disable
    # monitor=DP-1,disable  
    # monitor=DVI-D-2, 1920x1080@60, 3840x0, 1
    
    ## REGULAR
    monitor=DP-1, 1920x1080@240, 1920x0, 1
    monitor=HDMI-A-1, 1920x1080@60, 0x0, 1
    #monitor=HDMI-A-1,transform,1
    monitor=DVI-D-2, 1920x1080@60, 3840x0, 1
 
    monitor=, preffered, auto, 1

    workspace = 1, monitor:DP-1, default:true
    workspace = 2, monitor:DP-1, default:false
    workspace = 3, monitor:DP-1, default:false

    workspace = 4, monitor:DVI-D-2, default:true
    workspace = 5, monitor:DVI-D-2, default:false
    workspace = 6, monitor:DVI-D-2, default:false

    workspace = 7, monitor:HDMI-A-1, default:true
    workspace = 8, monitor:HDMI-A-1, default:false
    workspace = 9, monitor:HDMI-A-1, default:false

    bind = $mainMod, ESCAPE, exec, kitty sh -c "sudo nixos-rebuild switch; hyprctl reload; echo; echo 'Press enter to exit'; read"
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
