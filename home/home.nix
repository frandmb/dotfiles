{
  config,
  pkgs,
  inputs,
  ...
}:
let
  gpuAcceleration = builtins.getEnv "GPU_ACCELERATION";
in
{
  imports = [
    ./hardware/nvidia.nix
    ./hardware/radeon.nix
    ./hardware/other.nix
  ];
  nixpkgs.config.allowUnfree = true;
  home.username = "fran";
  home.homeDirectory = "/home/fran";

  programs.nvidia-packages.enable = gpuAcceleration == "CUDA";
  programs.radeon-packages.enable = gpuAcceleration == "HIP";
  programs.otherGpu-packages.enable = gpuAcceleration == "";

  home.packages = with pkgs; [
    alacritty
    kitty
    ripgrep
    fd
    lazygit
    just
    linux-wifi-hotspot
    orca-slicer
  ];

  home.file = {
    ".config/kitty".source = ./config/kitty;
  };

  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
