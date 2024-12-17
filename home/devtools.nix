{
  config,
  pkgs,
  ...
}:
{
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

    # Nix language tools
    alejandra
    nixd

    # Lua language tools
    stylua
  ];

  home.file = {
    ".config/kitty".source = ./config/kitty;
  };
}
