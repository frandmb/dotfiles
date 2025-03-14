{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.radeon-packages;
in {
  options.programs.radeon-packages = {
    enable = mkEnableOption "HIP enabled packages and patches for AMD GPUs";
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = "rocm";
    };
    home.packages = with pkgs; [
      blender-hip
    ];
  };
}
