{
  config,
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [
    cudaPackages.cudatoolkit
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
  hardware.nvidia-container-toolkit = {
    enable = true;
  };

  environment.variables = {
    GPU_ACCELERATION = "CUDA";
  };
}
