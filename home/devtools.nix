{
  config,
  pkgs,
  ...
}: let
  homedir = "${config.home.homeDirectory}";
  dotfiles = "${homedir}/.nix-conf/home/config";
  link = config.lib.file.mkOutOfStoreSymlink;
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

  home.file = {
    ".config/kitty".source = link "${dotfiles}/kitty";
    ".config/nvim".source = link "${dotfiles}/nvim";
    ".config/distrobox".source = link "${dotfiles}/distrobox";
  };
}
