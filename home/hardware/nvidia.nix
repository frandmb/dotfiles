{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.nvidia-packages;
in {
  options.programs.nvidia-packages = {
    enable = mkEnableOption "Packages and patches for Nvidia";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (blender.override {cudaSupport = true;})
    ];
  };
}
