# sudo just update desktop
update host:
  nixos-rebuild switch --flake .#{{host}} --impure

up:
  nix flake update

# Update specific input
# usage: make upp {{home-manager}}
upp home-manager:
  nix flake update {{home-manager}}
