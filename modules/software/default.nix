{ pkgs, config, ... }:

{
  programs.firefox.enable = false;
  programs.gnome-disks.enable = true;
  programs.kdeconnect.enable = true;
  environment.systemPackages = with pkgs; [
    ffmpeg-full
    tpm2-tss
    git
    distrobox
    wget
    gcc
    alacritty
    lazygit
    ripgrep
    fd
    kitty
    kdePackages.plasma-thunderbolt
    nixfmt-rfc-style
    cargo
    nodejs_22
    corepack_22
    wl-clipboard
    deno
    python3
    just
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
