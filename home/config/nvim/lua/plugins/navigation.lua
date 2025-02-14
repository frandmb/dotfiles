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

  -- support counts when navigating buffers
  {
    "akinsho/bufferline.nvim",
    keys = {
      {
        "L",
        function()
          vim.cmd("bnext " .. vim.v.count1)
        end,
        desc = "Next buffer",
      },
      {
        "H",
        function()
          vim.cmd("bprev " .. vim.v.count1)
        end,
        desc = "Previous buffer",
      },
      {
        "]b",
        function()
          vim.cmd("bnext " .. vim.v.count1)
        end,
        desc = "Next buffer",
      },
      {
        "[b",
        function()
          vim.cmd("bprev " .. vim.v.count1)
        end,
        desc = "Previous buffer",
      },
    },
  },
}
