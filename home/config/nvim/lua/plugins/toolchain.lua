return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "alejandra" },
        gdscript = { "gdformat" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {},
        nixd = {
          nixpkgs = {
            expr = "import <nixpkgs> { }",
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lint",
    opts = {
      linters_by_ft = {
        gdscript = { "gdlint" },
      },
    },
  },
}
