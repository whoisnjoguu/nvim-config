-- Leader must be set before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- UI (VS Code-ish: absolute line numbers, no tildes, always-on sign column)
opt.number = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.fillchars = { eob = " " }
opt.showmode = false
opt.laststatus = 3
opt.winborder = "rounded"
opt.pumheight = 12
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Editing
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
opt.undofile = true
opt.swapfile = false
opt.confirm = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Windows
opt.splitright = true
opt.splitbelow = true

-- Responsiveness
opt.updatetime = 250
opt.timeoutlen = 400
