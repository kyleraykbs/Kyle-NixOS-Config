{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.base.neovim;

  # XXXX = pkgs.vimUtils.buildVimPlugin {
  #   name = "XXXX";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "XXXX";
  #     repo = "XXXX";
  #     rev = "XXXX";
  #     # sha256 = "";
  #   };
  # };

  vim-better-whitespace = pkgs.vimUtils.buildVimPlugin {
      name = "vim-better-whitespace";
      src = pkgs.fetchFromGitHub {
        owner = "ntpeters";
        repo = "vim-better-whitespace";
        rev = "1b22dc57a2751c7afbc6025a7da39b7c22db635d";
        sha256 = "sha256-OZ25no2pZQfyb1Yo00rE2XgKop+xutloRAoE8Lfqv4M=";
      };
    };
  vim-airline = pkgs.vimUtils.buildVimPlugin {
    name = "vim-airline";
    src = pkgs.fetchFromGitHub {
      owner = "vim-airline";
      repo = "vim-airline";
      rev = "e6bb8427dc2d2dc3583ed1bf5ff6a9682c854d32";
      sha256 = "sha256-GxO3eIE2If0ob+2AkFa/MWCev7AED2nQgLnlwNG9cGk=";
    };
  };
  vim-easymotion = pkgs.vimUtils.buildVimPlugin {
    name = "vim-easymotion";
    src = pkgs.fetchFromGitHub {
      owner = "easymotion";
      repo = "vim-easymotion";
      rev = "b3cfab2a6302b3b39f53d9fd2cd997e1127d7878";
      sha256 = "sha256-4Xc7QHlS2zdVHksIMPZUkJcd8Urq3NK0AmKUHMFUYMA=";
    };
  };
  vim-fugitive = pkgs.vimUtils.buildVimPlugin {
    name = "vim-fugitive";
    src = pkgs.fetchFromGitHub {
      owner = "tpope";
      repo = "vim-fugitive";
      rev = "b3b838d690f315a503ec4af8c634bdff3b200aaf";
      sha256 = "sha256-JAlILa/7A9L10nWJh7IIfhdNn1tpVSKyhuc0oGTekvg=";
    };
  };
  nvim-treesitter = pkgs.vimUtils.buildVimPlugin {
  name = "nvim-treesitter";
  src = pkgs.fetchFromGitHub {
    owner = "nvim-treesitter";
    repo = "nvim-treesitter";
    rev = "80cee52d445363c8bd08eacca17be31e3837f4d0";
    sha256 = "sha256-qCbhKbCF0sib6wI+U0a7KlWm1xjSg+SK/WC3aL7awFs=";
    };
  };
  vim-devicons  = pkgs.vimUtils.buildVimPlugin {
  name = "vim-devicons";
  src = pkgs.fetchFromGitHub {
    owner = "ryanoasis";
    repo = "vim-devicons";
    rev = "71f239af28b7214eebb60d4ea5bd040291fb7e33";
    sha256 = "sha256-9g3UdBcc34MR/BrKYqOki2Ge29k/QaRMsnyY+Pq9UE8=";
    };
  };
  vim-workspace  = pkgs.vimUtils.buildVimPlugin {
    name = "vim-workspace";
    src = pkgs.fetchFromGitHub {
      owner = "thaerkh";
      repo = "vim-workspace";
      rev = "c0d1e4332a378f58bfdf363b4957168fa78e79b4";
      sha256 = "sha256-qCbhKbCF0sib6wI+U0a7KlWm1xjSg+SK/WC3aL7awFs=";
    };
  };
  vim-auto-save = pkgs.vimUtils.buildVimPlugin {
    name = "vim-auto-save";
    src = pkgs.fetchFromGitHub {
      owner = "907th";
      repo = "vim-auto-save";
      rev = "2e3e54ea4c0fc946c21b0a4ee4c1c295ba736ee8";
      sha256 = "sha256-sCUEGcIyJHs/Qqgl6246ZWcNokTR0h9+AA6SYzyMhtU=";
    };
  };
in
{
  options.base.neovim = {
    enable = mkEnableOption "Neovim";
    extraConfig = mkOption {
      type = types.str;
      default = "";
    };
    binds = {
      leader = mkOption {
        type = types.str;
        default = " ";
      };
      other = mkOption {
        type = types.str;
        default = "";
      };
    };
    plugins = {
      nerdtree = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        binds = {
          toggle = mkOption {
            type = types.str;
            default = "<leader>nt";
          };
        };
      };
      startify = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        config = {
          header =  {
            enable = mkOption {
              type = types.bool;
              default = false;
            };
            text = mkOption {
              type = types.str;
              default = "";
            };
          };
        };
      };
      nerdcommenter = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        binds = {
          defaultBinds = mkOption {
            type = types.bool;
            default = false;
          };
        };
        config = {
          whiteSpace = mkOption {
            type = types.bool;
            default = false;
          };
        };
      };
      ale = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
      indentLine = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        config = {
          char = mkOption {
            type = types.str;
            default = "¦";
          };
        };
      };
      whichKey = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        binds = {
          leader = mkOption {
            type = types.str;
            default = "<leader>";
          };
        };
      };
      autoPairs = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
      whiteSpace = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
      airLine = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
      easyMotion = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
      polygot = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
      fugitive = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
      treeSitter = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
      devicons = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
      workSpace = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        config = {
          autoSession = mkOption {
            type = types.bool;
            default = false;
          };
          sessionName = mkOption {
            type = types.str;
            default = "Session.vim";
          };
          sessionDir = {
            enable = mkOption {
              type = types.bool;
              default = false;
            };
            path = mkOption {
              type = types.str;
              default = "";
            };
          };
          autoSave = mkOption {
            type = types.bool;
            default = false;
          };
        };
      };
      autoSave = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
        onStart = mkOption {
          type = types.bool;
          default = false;
          };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      # add this line to config once syntax is right: ${(if cfg.plugins.workSpace.config.sessionDir.enable then "let g:workspace_session_directory = " cfg.plugins.workSpace.config.sessionDir.path else null)}
      # add this line to config once syntax is right: ${(if cfg.plugins.startify.config.header.enable then "let g:workspace_session_directory = " cfg.plugins.startify.config.header.text else null)}
      extraConfig = ''
        " binds
        let mapleader = "${cfg.binds.leader}"
        nnoremap ${cfg.plugins.whichKey.binds.leader} :WhichKey <Space><CR><space>
        nnoremap ${cfg.plugins.nerdtree.binds.toggle} :NERDTreeToggle<cr>
	set tabstop=4
	set shiftwidth=4
	set expandtab
        ${cfg.binds.other}
        " options
        let g:NERDCreateDefaultMappings = ${(if cfg.plugins.nerdcommenter.binds.defaultBinds then "1" else "0")}
        let g:NERDSpaceDelims = ${(if cfg.plugins.nerdcommenter.config.whiteSpace then "1" else "0")}
        let g:workspace_session_name = ${(if cfg.plugins.workSpace.config.autoSession then "1" else "0")}
        let g:workspace_autosave = ${(if cfg.plugins.workSpace.config.autoSave then "1" else "0")}
        let g:auto_save = ${(if cfg.plugins.autoSave.onStart then "1" else "0")}
        let g:indentline_char = ${cfg.plugins.indentLine.config.char}
        ${cfg.extraConfig}
      '';
      plugins = with pkgs.vimPlugins; [
        (mkIf cfg.plugins.startify.enable vim-startify)
        (mkIf cfg.plugins.nerdtree.enable nerdtree)        
        (mkIf cfg.plugins.nerdcommenter.enable nerdcommenter)
        (mkIf cfg.plugins.ale.enable ale)
        (mkIf cfg.plugins.indentLine.enable indentLine)
        (mkIf cfg.plugins.whichKey.enable which-key-nvim)
        (mkIf cfg.plugins.autoPairs.enable auto-pairs)
        (mkIf cfg.plugins.whiteSpace.enable vim-better-whitespace)
        (mkIf cfg.plugins.airLine.enable vim-airline)
        (mkIf cfg.plugins.easyMotion.enable vim-easymotion)
        (mkIf cfg.plugins.fugitive.enable vim-fugitive)
        (mkIf cfg.plugins.treeSitter.enable nvim-treesitter)
        (mkIf cfg.plugins.devicons.enable vim-devicons)
        (mkIf cfg.plugins.workSpace.enable vim-workspace)
        (mkIf cfg.plugins.autoSave.enable vim-auto-save)
      ];
    };
  };
}
