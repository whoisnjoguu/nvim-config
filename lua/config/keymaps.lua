local map = vim.keymap.set

-- Save (Ctrl+S), mode-preserving like VS Code
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Toggle comment (Ctrl+/; <C-_> is what legacy terminals send for Ctrl+/)
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
map("x", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })
map("n", "<C-_>", "gcc", { remap = true, desc = "Toggle comment" })
map("x", "<C-_>", "gc", { remap = true, desc = "Toggle comment" })

-- Move lines (Alt+Up/Down)
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("x", "<A-Down>", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move selection down" })
map("x", "<A-Up>", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move selection up" })

-- Keep selection when indenting (like VS Code Tab/Shift+Tab on selections)
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

-- Terminal: double-Esc back to normal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Quit (prompts to save, like VS Code)
map("n", "<leader>q", "<cmd>confirm qall<cr>", { desc = "Quit" })
