{
  hostname = "comet";
  style = rec {
    border_size = "3";
    wallpaper = ./wallpaper.png;
    wallpaperpath = (builtins.path {path = wallpaper;});
  };
}