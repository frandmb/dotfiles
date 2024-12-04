{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ffmpeg-full
    tpm2-tss
    git
    distrobox
    wget
    gcc
    kdePackages.plasma-thunderbolt
    nixfmt-rfc-style
    cargo
    nodejs_22
    corepack_22
    wl-clipboard
    deno
    python3
    alsa-utils
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
