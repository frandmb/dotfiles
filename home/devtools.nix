{
  config,
  pkgs,
  ...
}: let
  link = config.lib.file.mkOutOfStoreSymlink;
  dir = builtins.toString ./.;
  dotfilesPath = "${dir}/config";
  dotfilesConfig = builtins.listToAttrs (builtins.map (name: {
    name = ".config/${name}";
    value = {source = link "${dotfilesPath}/${name}";};
  }) (builtins.attrNames (builtins.readDir dotfilesPath)));
in {
  home.packages = with pkgs; [
    kitty
    ripgrep
    fd
    fzf
    lazygit
    just

    tree-sitter
    jupyter

    rustup

    deno
    nodejs_22
    corepack_22

    # Nix language tools
    alejandra
    nixd

    # Lua language tools
    stylua
  ];

  home.file = dotfilesConfig;
}
