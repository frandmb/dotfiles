{
  config,
  pkgs,
  ...
}:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [
    cudaPackages.cudatoolkit
    (blender.override { cudaSupport = true; })
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  hardware.nvidia-container-toolkit = {
    enable = true;
  };
}
