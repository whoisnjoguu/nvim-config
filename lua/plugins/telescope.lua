return {
  -- Fuzzy finder (Ctrl+P / Ctrl+Shift+F / Ctrl+Shift+P)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<C-S-p>", "<cmd>Telescope commands<cr>", desc = "Command palette" },
      { "<C-S-f>", "<cmd>Telescope live_grep<cr>", desc = "Search in files" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Search in files" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols (Ctrl+Shift+O)" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics (Problems panel)" },
    },
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
