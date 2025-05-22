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

    xdg.desktopEntries = {
      orca-nvidia = {
        name = "OrcaSlicer Nvidia";
        genericName = "Slicer";
        exec = "__EGL_VENDOR_LIBRARY_FILENAMES=${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json ${pkgs.orca-slicer}/bin/orca-slicer";
        terminal = false;
      };
    };
  };
}
