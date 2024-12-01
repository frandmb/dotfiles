# sudo just deploy desktop
build host:
  nixos-rebuild switch --flake .#{{host}} --impure

build-home:
  home-manager switch --flake .

up:
  nix flake update

# Update specific input
upp flake-url:
  nix flake update {{flake-url}}


cleanup:
  nix-collect-garbage --delete-older-than 7d
