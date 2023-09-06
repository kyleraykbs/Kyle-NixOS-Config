{config, pkgs, inputs, ...}: {
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    comma
    git-lfs
  ];

  base.fish.enable = true;

  programs = {
    kitty = {
      enable = true;
      settings = {
        opacity = "0.5";
        confirm_os_window_close = 0;
      };
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
