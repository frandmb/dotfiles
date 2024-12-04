{
  description = "My Nix Flake";
  nixConfig = {
    extra-substituters = [
      "https://cuda-maintainers.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-unstable-small = {
      url = "github:nixos/nixpkgs/nixos-unstable-small";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      sysModules = [
        /etc/nixos/hardware-configuration.nix
        ./hosts/base.nix
        ./modules/key-remap.nix
        ./modules/software/default.nix
        ./modules/fhs-compat.nix
      ];
    in
    {
      nixosConfigurations = {
        # sudo nixos-rebuild switch --flake .#fran-desktop
        fran-desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = sysModules ++ [
            ./hosts/desktop/config.nix
            ./modules/nvidia.nix
          ];
        };

        # sudo nixos-rebuild switch --flake .#fran-laptop
        fran-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = sysModules ++ [
            ./hosts/laptop/config.nix
            ./modules/radeon.nix
          ];
        };
      };

      homeConfigurations = {
        fran = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/home.nix ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
