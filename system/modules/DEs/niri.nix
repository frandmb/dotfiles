{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.dankMaterialShell.nixosModules.dankMaterialShell
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  config = {
    environment.systemPackages = with pkgs; [
      gnome-keyring
      xwayland-satellite
      kdePackages.polkit-qt-1
      kdePackages.qt6ct
      bibata-cursors
    ];
    programs.niri = {
      enable = true;
    };

    programs.dankMaterialShell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      greeter = {
        enable = true;
        compositor.name = "niri";
      };
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];

    environment.variables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };

    hardware.i2c.enable = true;

    users.users.fran = {
      extraGroups = ["i2c"];
    };
  };
}
