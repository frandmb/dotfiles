{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ffmpeg-full
    tpm2-tss
    distrobox
    wget
    gcc
    cargo
    wl-clipboard
    kdePackages.plasma-thunderbolt
    alsa-utils
    pciutils
    wirelesstools
    busybox
    libGL
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox.enable = false;
    gnome-disks.enable = true;
    kdeconnect.enable = true;
    git = {
      enable = true;
      lfs.enable = true;
    };
  };
}
