return {
  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        },
        position = "float",
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
