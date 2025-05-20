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
        eslint = {
          experimental = {
            useFlatConfig = true,
          },
          codeActionOnSave = {
            enable = true,
            mode = "all",
          },
        },
        gdscript = { mason = false },
        gopls = { mason = false },
        nixd = {
          mason = false,
          nixpkgs = {
            expr = "import <nixpkgs> { }",
          },
        },
      },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "vtsls" or client.name == "volar" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
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
