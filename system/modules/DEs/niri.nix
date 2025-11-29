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
      adw-gtk3
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
      pkgs.xdg-desktop-portal-wlr
    ];

    environment.variables = {
      TZ = "America/Buenos_Aires";
    };

    hardware.i2c.enable = true;

    users.users.fran = {
      extraGroups = ["i2c"];
    };
  };
}
