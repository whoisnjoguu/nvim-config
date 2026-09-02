-- Force github plugin clones over HTTPS even when the user's global gitconfig
-- rewrites https://github.com -> git@github.com (SSH).
do
  local real = vim.fn.expand("~/.gitconfig")
  if vim.fn.filereadable(real) == 1 then
    local kept, in_url = {}, false
    for _, line in ipairs(vim.fn.readfile(real)) do
      local section = line:match("^%s*%[%s*(.-)%s*%]")
      if section then
        in_url = section:match('^url[%s"]') ~= nil
      end
      if not in_url then
        kept[#kept + 1] = line
      end
    end
    local sanitized = vim.fn.stdpath("state") .. "/git-config"
    vim.fn.mkdir(vim.fn.fnamemodify(sanitized, ":h"), "p")
    vim.fn.writefile(kept, sanitized)
    vim.env.GIT_CONFIG_GLOBAL = sanitized
  end
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n" .. out, "ErrorMsg" } }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },
  install = { colorscheme = { "vscode" } },
  checker = { enabled = false },
  change_detection = { notify = false },
  rocks = { enabled = false },
})
