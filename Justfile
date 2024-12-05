# sudo just deploy desktop
build host:
  nixos-rebuild switch --flake .#{{host}} --impure --accept-flake-config

rebuild:
  nixos-rebuild switch --flake .#$HOSTNAME --impure --accept-flake-config

build-home:
  home-manager switch --flake .

build-home-force:
  home-manager switch --flake . -b backup

up:
  nix flake update

# Update specific input
upp flake-url:
  nix flake update {{flake-url}}


cleanup:
  nix-collect-garbage --delete-older-than 7d
