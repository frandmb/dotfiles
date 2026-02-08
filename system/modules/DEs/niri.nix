{pkgs, ...}: {
  config = {
    environment.systemPackages = with pkgs; [
      gnome-keyring
      xwayland-satellite
      kdePackages.polkit-qt-1
      kdePackages.qt6ct
      adw-gtk3
      nemo
      kdePackages.ark
      swayimg
      xdg-desktop-portal-termfilechooser
    ];
    qt = {
      enable = true;
      platformTheme = "qt5ct";
    };

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
    programs.dsearch.enable = true;
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
    xdg.terminal-exec = {
      enable = true;
      settings = {
        default = [
          "wezterm.desktop"
        ];
      };
    };

    environment.variables = {
      TZ = "America/Buenos_Aires";
      TERMINAL = "wezterm";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      QT_QPA_PLATFORM = "wayland";
      NIXOS_OZONE_WL = "1";
    };

    hardware.i2c.enable = true;

    users.users.fran = {
      extraGroups = ["i2c"];
    };
  };
}
