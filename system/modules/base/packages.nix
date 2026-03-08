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
    neovim-unwrapped
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDO_EDITOR = "nvim";
  };

  programs = {
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
