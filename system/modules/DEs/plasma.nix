{pkgs, ...}: {
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    wayland.enable = true;
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    kdePackages.plasma-thunderbolt
  ];
}
