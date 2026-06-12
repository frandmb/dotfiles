return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "alejandra" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          settings = {
            experimental = {
              useFlatConfig = true,
            },
          },
        },
        unocss = {
          on_init = function(client)
            if client.server_capabilities then
              client.server_capabilities.colorProvider = false
            end
          end,
        },
        denols = {
          mason = false,
          root_dir = require("lspconfig").util.root_pattern({ "deno.json", "deno.jsonc" }),
          settings = {
            deno = {
              inlayHints = {
                parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enable = true },
                enumMemberValues = { enabled = true },
              },
            },
          },
        },
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
          Snacks.util.lsp.on({}, function(_, client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif vim.tbl_contains({ "vtsls", "vue_ls", "volar", "tsserver", "oxfmt" }, client.name) then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "gdshader",
      },
    },
  },
  {
    "nvim-mini/mini.cursorword",
    version = "*",
    opts = {},
  },
}
