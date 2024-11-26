{ ... }:
{
  imports = [
    ./../../modules/nvidia.nix
  ];
  networking.hostName = "fran-desktop";
}
