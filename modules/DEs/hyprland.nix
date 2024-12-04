{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    mako # Notifications daemon
    libnotify
    rofi-wayland
    swww
    (pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
    networkmanagerapplet
    grim # Screenshot tool
    slurp # select tool
  ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
