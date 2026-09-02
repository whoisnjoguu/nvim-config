# nvim

Neovim config that feels like VS Code.

## Install

**macOS / Linux** — the script auto-installs deps via Homebrew, apt, dnf, pacman, or zypper, backs up any existing `~/.config/nvim`, clones, and bootstraps plugins:

```sh
curl -fsSL https://raw.githubusercontent.com/whoisnjoguu/nvim-config/main/install.sh | sh
```

**Windows** (PowerShell) — auto-installs deps via winget, scoop, or choco into `%LOCALAPPDATA%\nvim`:

```powershell
irm https://raw.githubusercontent.com/whoisnjoguu/nvim-config/main/install.ps1 | iex
```

Or manually:

```sh
# macOS
brew install ripgrep fd tree-sitter-cli
# Debian/Ubuntu
sudo apt install ripgrep fd-find build-essential
# Arch
sudo pacman -S ripgrep fd tree-sitter-cli

git clone https://github.com/whoisnjoguu/nvim-config ~/.config/nvim
nvim
```

First launch bootstraps lazy.nvim, installs plugins, compiles treesitter parsers, and Mason installs LSP servers (gopls, lua_ls, ts_ls, jsonls, yamlls) plus stylua/goimports.

## Keymaps (VS Code → Neovim)

Leader is `Space`. Ctrl+Shift combos require a terminal with the kitty keyboard protocol (Ghostty, kitty, WezTerm, iTerm2); each has a leader fallback.

| VS Code        | Neovim                   | Action                  |
| -------------- | ------------------------ | ----------------------- |
| Ctrl+P         | `<C-p>` / `<leader>ff`   | Find files              |
| Ctrl+Shift+P   | `<C-S-p>`                | Command palette         |
| Ctrl+Shift+F   | `<C-S-f>` / `<leader>fg` | Search in files         |
| Ctrl+B         | `<C-b>`                  | Toggle explorer         |
| Ctrl+`         | ``<C-`>`` / `<C-\>`      | Toggle terminal         |
| Ctrl+S         | `<C-s>`                  | Save                    |
| Ctrl+/         | `<C-/>`                  | Toggle comment          |
| Alt+Up/Down    | `<A-Up>` / `<A-Down>`    | Move line               |
| Ctrl+Tab       | `<Tab>` / `<S-Tab>`      | Next/prev buffer        |
| Ctrl+W         | `<leader>x`              | Close buffer            |
| F12 / gd       | `<F12>` / `gd`           | Go to definition        |
| Shift+F12      | `gr`                     | Find references         |
| F2             | `<F2>` / `<leader>rn`    | Rename symbol           |
| Ctrl+.         | `<leader>ca`             | Code action / quick fix |
| Ctrl+Shift+O   | `<leader>fs`             | Document symbols        |
| Problems panel | `<leader>fd`             | Workspace diagnostics   |
| Shift+Alt+F    | `<leader>cf`             | Format document         |

