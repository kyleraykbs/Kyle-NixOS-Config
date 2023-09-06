{config, pkgs, inputs, ...}: {
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    comma
    git
  ];

  base.fish.enable = true;
}
