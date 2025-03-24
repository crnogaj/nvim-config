return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    enabled = true,
    lazy = false,
    config = function() end,
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
      }
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has "nvim-0.10.0" == 1,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        ignore = false,
      },
    },
  },
}
