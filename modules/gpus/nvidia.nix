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

  nixpkgs.config.allowUnfreePredicate = p:
    builtins.all (
      license:
        license.free
        || builtins.elem license.shortName [
          "CUDA EULA"
          "cuDNN EULA"
          "cuTENSOR EULA"
          "NVidia OptiX EULA"
        ]
    ) (
      if builtins.isList p.meta.license
      then p.meta.license
      else [p.meta.license]
    );

  environment.variables = {
    GPU_ACCELERATION = "CUDA";
    CUDA_PATH = pkgs.cudatoolkit;
  };
}
