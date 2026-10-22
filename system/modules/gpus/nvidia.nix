{
  config,
  pkgs,
  lib,
  ...
}: let
  nvidiaPackage = config.boot.kernelPackages.nvidiaPackages.latest;
  cdiHookPath = "${pkgs.nvidia-container-toolkit.tools}/bin/nvidia-cdi-hook";
in {
  services.xserver.videoDrivers = ["nvidia"];

  nixpkgs.config = {
    cudaSupport = true;
  };

  environment.systemPackages = with pkgs; [
    cudaPackages.cudatoolkit
    egl-wayland
  ];

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;
    nvidiaSettings = true;
    package = nvidiaPackage;
  };
  hardware.nvidia-container-toolkit = {
    enable = true;
  };

  environment.variables = {
    GPU_ACCELERATION = "CUDA";
    CUDA_PATH = pkgs.cudatoolkit;
    CUDAToolkit_ROOT = pkgs.cudatoolkit;
    # LD_LIBRARY_PATH = "${nvidiaPackage}/lib";
    EXTRA_LDFLAGS = "-L/lib -L${nvidiaPackage}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";
    LIBVA_DRIVER_NAME = "nvidia";
    NVIDIA_CDI_HOOK_PATH = cdiHookPath;
  };
}
