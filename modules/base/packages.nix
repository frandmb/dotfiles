{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ffmpeg-full
    tpm2-tss
    git
    distrobox
    wget
    gcc
    cargo
    wl-clipboard
    kdePackages.plasma-thunderbolt
    alsa-utils
    pciutils
    wirelesstools
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox.enable = false;
    gnome-disks.enable = true;
    kdeconnect.enable = true;
  };
}
