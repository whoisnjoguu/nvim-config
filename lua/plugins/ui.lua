return {
  -- VS Code Dark+ theme
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode").setup({ italic_comments = true })
      vim.cmd.colorscheme("vscode")
    end,
  },

  -- Buffer tabs along the top
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<leader>x", "<cmd>bdelete<cr>", desc = "Close buffer" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        separator_style = "thin",
        show_close_icon = false,
        offsets = {
          { filetype = "neo-tree", text = "EXPLORER", text_align = "left", separator = true },
        },
      },
    },
  },

  -- Status bar
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "vscode",
        globalstatus = true,
        section_separators = "",
        component_separators = "",
      },
    },
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Keybinding hints popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
