{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lact
  ];
}
