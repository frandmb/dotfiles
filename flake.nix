{
  description = "My Nix Flake";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:nixos/nixos-hardware/master";
    };
    nixos-unstable-small = {
      url = "github:nixos/nixpkgs/nixos-unstable-small";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    sysModules = [
      /etc/nixos/hardware-configuration.nix
      ./hosts/base.nix
      ./modules/base/packages.nix
      ./modules/base/fonts.nix
      ./modules/fhs-compat.nix
      ./modules/key-remap.nix
      ./modules/virt-manager.nix
    ];
  in {
    nixosConfigurations = {
      # sudo nixos-rebuild switch --flake .#fran-desktop
      fran-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules =
          sysModules
          ++ [
            ./hosts/desktop/config.nix
            ./modules/nvidia.nix
            ./modules/DEs/plasma.nix
            #./modules/DEs/hyprland.nix
          ];
      };

      # sudo nixos-rebuild switch --flake .#fran-laptop
      fran-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules =
          sysModules
          ++ [
            ./hosts/laptop/config.nix
            ./modules/radeon.nix
            ./modules/DEs/plasma.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen4
          ];
      };
    };

    homeConfigurations = {
      fran = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/home.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
