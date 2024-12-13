{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.otherGpu-packages;
in
{
  options.programs.otherGpu-packages = {
    enable = mkEnableOption "Packages without specific GPU patches or versions";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      blender
    ];
  };
}
