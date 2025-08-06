{
  config,
  pkgs,
  lib,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];

  nixpkgs.config = {
    cudaSupport = true;
  };

  environment.systemPackages = with pkgs; [
    cudaPackages.cudatoolkit
    nvidia-docker
    egl-wayland
  ];

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
    kernelParams = ["nvidia_drm.fbdev=1"];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
  hardware.nvidia-container-toolkit = {
    enable = true;
  };

  environment.variables = {
    GPU_ACCELERATION = "CUDA";
    CUDA_HOME = pkgs.cudatoolkit;
    LIBVA_DRIVER_NAME = "nvidia";
  };
}
