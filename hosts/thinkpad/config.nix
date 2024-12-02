{ pkgs, ... }:
{
  imports = [
    ./../../modules/radeon.nix
  ];
  networking.hostName = "fran-thinkpad";
}
