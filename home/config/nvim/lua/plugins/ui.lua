return {
  -- Theme
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      style = "night",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_z = {},
      },
    },
  },
}
