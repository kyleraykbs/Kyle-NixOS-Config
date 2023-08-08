{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.base.neovim;
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
        default = "-";
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
      vim-startify = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      extraConfig = ''
        let mapleader = "${cfg.binds.leader}"
        nnoremap ${cfg.plugins.nerdtree.binds.toggle} :NERDTreeToggle<cr>
        ${cfg.extraConfig}
      '';
      plugins = with pkgs.vimPlugins; [
        (mkIf cfg.plugins.vim-startify.enable vim-startify)
        (mkIf cfg.plugins.nerdtree.enable {
          plugin = nerdtree;
          config = "";
        })
      ];
    };
  };
}