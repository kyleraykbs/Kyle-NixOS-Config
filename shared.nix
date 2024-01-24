{lib, ...}: 
let
  inherit (lib)
    mkOption
    types
    ;
in
{
  options.shared = {
    style = {
        wallpaper = mkOption {
            type = types.path;
            default = ./wallpaper/sussy.png;
        };
    };
    system = {
        users = {
            perms = mkOption {
                type = types.listOf types.str;
                default = [ "networkmanager" "wheel" "libvirtd" "dialout" "tty" "adbusers" "docker" ];
            };
        };
    };
  };
}
