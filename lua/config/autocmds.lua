local aug = vim.api.nvim_create_augroup("user", { clear = true })

-- Flash yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = aug,
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Restore cursor to last position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = aug,
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Go uses real tabs
vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-- 2-space indents for web/config filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "jsonc", "yaml", "html", "css", "lua" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})
