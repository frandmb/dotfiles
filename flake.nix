{
  description = "My Nix Flake";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
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
        # sudo nixos-rebuild switch --flake .#desktop
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = sysModules ++ [
            ./hosts/desktop/config.nix
          ];
        };

        # sudo nixos-rebuild switch --flake .#thinkpad
        thinkpad = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = sysModules ++ [
            ./hosts/thinkpad/config.nix
          ];
        };
      };

      homeConfigurations = {
        fran = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/home.nix ];
        };
      };
    };
}
