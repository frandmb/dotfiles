{ ... }:
{
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];
}
