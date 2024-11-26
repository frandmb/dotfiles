{ ... }:
{
  imports = [
    ./../../modules/radeon.nix
  ];
  networking.hostName = "fran-thinkpad";
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];
}
