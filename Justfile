# sudo just build desktop
build host:
  nixos-rebuild switch --flake .#{{host}} --impure --accept-flake-config

rebuild:
  nixos-rebuild switch --flake .#$HOSTNAME --impure --accept-flake-config

build-home:
  home-manager switch --flake . --impure

build-home-force:
  home-manager switch --flake . -b backup --impure

up:
  nix flake update

# Update specific input
upp flake-url:
  nix flake update {{flake-url}}


cleanup:
  nix-collect-garbage --delete-older-than 7d

enroll-key:
	systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0 /dev/nvme1n1p2

# Setup Nvidia CDI hook
setup-cdi:
	nvidia-ctk cdi generate --output=/tmp/cdi/nvidia.yaml --nvidia-cdi-hook-path=${NVIDIA_CDI_HOOK_PATH}
