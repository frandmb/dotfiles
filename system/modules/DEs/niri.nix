{pkgs, ...}: {
  config = {
    environment.systemPackages = with pkgs; [
      gnome-keyring
      xwayland-satellite
      kdePackages.polkit-qt-1
      kdePackages.qt6ct
      bibata-cursors
      adw-gtk3
      kdePackages.dolphin
      kdePackages.ark
      swayimg
    ];

    services = {
      upower.enable = true;
      tuned = {
        enable = true;
        ppdSupport = true;
      };
    };
    programs.niri = {
      enable = true;
    };

    programs.dms-shell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    };
    services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
    ];

    environment.variables = {
      TZ = "America/Buenos_Aires";

      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
      NIXOS_OZONE_WL = "1";
    };

    hardware.i2c.enable = true;

    users.users.fran = {
      extraGroups = ["i2c"];
    };
  };
}
