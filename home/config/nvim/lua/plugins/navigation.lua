return {
  -- File explorer
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            auto_close = true,
            layout = {
              preset = "default",
              preview = "preview",
            },
          },
        },
      },
    },
  },
}
