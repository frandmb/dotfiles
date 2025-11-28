{pkgs, ...}: let
  gpuAcceleration = builtins.getEnv "GPU_ACCELERATION";
in {
  imports = [
    ./hardware/nvidia.nix
    ./hardware/radeon.nix
    ./hardware/other.nix
    ./devtools.nix
  ];

  nixpkgs.config.allowUnfree = true;
  home.username = "fran";
  home.homeDirectory = "/home/fran";

  home.packages = with pkgs; [
    linux-wifi-hotspot
    game-devices-udev-rules
  ];

  programs = {
    nvidia-packages.enable = gpuAcceleration == "CUDA";
    radeon-packages.enable = gpuAcceleration == "HIP";
    otherGpu-packages.enable = gpuAcceleration == "";
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    starship.enable = true;

    bash = {
      enable = true;
      bashrcExtra = ''
        function set_win_title(){
        	echo -ne "\033]0; $PWD \007"
        }
        starship_precmd_user_func="set_win_title"'';
    };
    home-manager.enable = true;
  };
  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    ssh-agent.enable = true;
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
