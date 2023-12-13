{ config, inputs, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.base.monitors;
in
{
  options.base.monitors = {
    monitors = mkOption {
      type = types.listOf types.attrs;
      default = [
	# TIP: The position is calculated with the scaled (and transformed) resolution, meaning if you want your 4K monitor with scale 2 to the left of your 1080p one, you’d use the position 1920x0 for the second screen. (3840 / 2) If the monitor is also rotated 90 degrees (vertical), you’d use 1080x0.
        # TIP: for resolution if you put "maxres" it will use the highest resolution, if you put "maxrr" it will pick the highest refresh rate, or if you put "default" it will pick the monitors default resolutio; all of these of course invalidate frame_rate.
	#
        # TEMPLATE OPTIONS
        # {resolution="1920x1080"; framerate=60; position="0x0"; adapter="DP-1"; scale=1; transform=0; mirroring="DP-2";}
      ];
    };
    workspaces = {
      mouseBased = mkOption {
        type = types.bool;
	default = true;
      };
    };
    defaultMonitor = mkOption {
      type = types.attrs;
      # Same thing as monitors just without the adapter property
      default = {resolution="default"; scale=1;};
    };
  };
}
