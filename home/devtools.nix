{
  config,
  pkgs,
  ...
}: let
  link = config.lib.file.mkOutOfStoreSymlink;
  src = builtins.getEnv "PWD";
  dotfilesPath = "${src}/home/config";
  dotfilesConfig = builtins.listToAttrs (builtins.map (name: {
    name = ".config/${name}";
    value.source = link "${dotfilesPath}/${name}";
  }) (builtins.attrNames (builtins.readDir dotfilesPath)));
in {
  home.packages = with pkgs; [
    kitty
    rio

    ripgrep
    fd
    fzf
    lazygit
    just

    tree-sitter
    jupyter

    rustup

    helix

    deno
    nodejs_22
    corepack_22

    # Nix language tools
    alejandra
    nixd

    # Lua language tools
    stylua
  ];

  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.config.show_banner = false
    '';
  };

  home.file = dotfilesConfig;
}
