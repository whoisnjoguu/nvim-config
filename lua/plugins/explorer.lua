return {
  -- File explorer sidebar (Ctrl+B like VS Code)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<C-b>", "<cmd>Neotree toggle<cr>", desc = "Toggle explorer" },
      { "<C-S-e>", "<cmd>Neotree reveal<cr>", desc = "Reveal file in explorer" },
      { "<leader>ee", "<cmd>Neotree reveal<cr>", desc = "Reveal file in explorer" },
    },
    opts = {
      close_if_last_window = true,
      window = { position = "left", width = 32 },
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
}
