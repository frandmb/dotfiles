{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ffmpeg-full
    tpm2-tss
    distrobox
    wget
    gcc
    cargo
    wl-clipboard
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
    git = {
      enable = true;
      lfs.enable = true;
    };
    firejail.enable = true;
  };
  # required for kde-connect
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}
