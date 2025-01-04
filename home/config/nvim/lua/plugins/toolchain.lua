return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "alejandra" },
        gdscript = {
          "gdformat",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = { mason = false },
        gopls = { mason = false },
        nixd = {
          mason = false,
          nixpkgs = {
            expr = "import <nixpkgs> { }",
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        gdscript = { "gdlint" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "gdscript",
        "gdshader",
        "godot_resource",
      },
    },
  },
  {
    "echasnovski/mini.cursorword",
    version = "*",
    opts = {},
  },
}
