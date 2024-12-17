{
  config,
  pkgs,
  ...
}: let
  homedir = "${config.home.homeDirectory}";
  dotfiles = "${homedir}/.dotfiles/home/config";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  home.packages = with pkgs; [
    alacritty
    kitty
    ripgrep
    fd
    fzf
    lazygit
    just
    deno
    nodejs_22
    corepack_22
    python3
    tree-sitter

    # Nix language tools
    alejandra
    nixd

    # Lua language tools
    stylua
  ];

  home.file = {
    ".config/kitty".source = link "${dotfiles}/kitty";
    ".config/nvim".source = link "${dotfiles}/nvim";
  };
}
