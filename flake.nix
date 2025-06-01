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
    # hyprland = {
    #  url = "github:hyprwm/Hyprland";
    # };
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    sysModules = [
      /etc/nixos/hardware-configuration.nix
      ./system/hosts/base.nix
      ./system/modules/base/packages.nix
      ./system/modules/base/fonts.nix
      ./system/modules/fhs-compat.nix
      ./system/modules/virtualization.nix
      ./system/modules/v4l2loopback.nix
      ./system/modules/waydroid.nix
      ./system/modules/bluetooth.nix
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
            ./system/hosts/desktop/config.nix
            ./system/modules/gpus/nvidia.nix
            ./system/modules/DEs/plasma.nix
            ./system/modules/gpus/lact.nix
            #./system/modules/DEs/hyprland.nix
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
            ./system/hosts/laptop/config.nix
            ./system/modules/gpus/radeon.nix
            ./system/modules/DEs/plasma.nix
            ./system/modules/fingerprint.nix
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
