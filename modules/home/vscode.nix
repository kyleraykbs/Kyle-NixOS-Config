{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf   
    mkOption 
    types   
    ;
  cfg = config.base.vscode;
in
{
  options.base.vscode = {
    enable = mkEnableOption "vscode";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      userSettings = {
        "window.titleBarStyle" = "custom";
        "[nix]"."editor.tabSize" = 2;
        "workbench.colorTheme" = "Wal";
      };
    };
  };
}
