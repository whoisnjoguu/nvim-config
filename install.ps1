#Requires -Version 5.1
<#
.SYNOPSIS
  Installs the nvim-config Neovim configuration on Windows.
.DESCRIPTION
  Run in PowerShell:
    irm https://raw.githubusercontent.com/whoisnjoguu/nvim-config/main/install.ps1 | iex
#>
$ErrorActionPreference = 'Stop'

$RepoUrl = 'https://github.com/whoisnjoguu/nvim-config'
$Dest = Join-Path $env:LOCALAPPDATA 'nvim'

function Say  ($m) { Write-Host "==> $m" -ForegroundColor Cyan }
function Warn ($m) { Write-Host "warn: $m" -ForegroundColor Yellow }
function Die  ($m) { Write-Host "error: $m" -ForegroundColor Red; exit 1 }
function Have ($c) { [bool](Get-Command $c -ErrorAction SilentlyContinue) }

if (-not (Have git))  { Die 'git is required (https://git-scm.com)' }
if (-not (Have nvim)) { Die 'neovim is required (https://neovim.io)' }

& nvim --headless "+lua if vim.fn.has('nvim-0.11') == 0 then os.exit(1) end" +q 2>$null
if ($LASTEXITCODE -ne 0) { Die 'neovim 0.11+ is required' }

# Install search/build tooling via winget, then scoop, then choco.
function Install-Tool {
  param([string]$Cmd, [string]$Winget, [string]$Scoop, [string]$Choco)
  if (Have $Cmd) { return }
  Say "Installing $Cmd"
  try {
    if (Have winget) {
      winget install --id $Winget --accept-source-agreements --accept-package-agreements -e -h
    } elseif (Have scoop) {
      scoop install $Scoop
    } elseif (Have choco) {
      choco install $Choco -y
    } else {
      Warn "no package manager (winget/scoop/choco) found; install $Cmd manually"
    }
  } catch {
    Warn "could not auto-install ${Cmd}: $_"
  }
}

#            Cmd            winget id                 scoop        choco
Install-Tool 'rg'          'BurntSushi.ripgrep.MSVC' 'ripgrep'    'ripgrep'
Install-Tool 'fd'          'sharkdp.fd'              'fd'         'fd'
Install-Tool 'tree-sitter' 'tree-sitter.tree-sitter' 'tree-sitter' 'tree-sitter'

# A C compiler is needed to build some treesitter parsers. zig is the easiest on Windows.
if (-not ((Have cc) -or (Have gcc) -or (Have cl) -or (Have zig))) {
  Warn 'no C compiler found; install zig (winget install zig.zig) or MSVC Build Tools for treesitter parser builds'
}

# Existing install: update in place. Anything else: back it up.
if (Test-Path $Dest) {
  $origin = (& git -C $Dest remote get-url origin 2>$null)
  if ($origin -and $origin -match 'nvim-config') {
    Say 'Existing install detected, pulling latest'
    & git -C $Dest pull --ff-only
  } else {
    $backup = "$Dest.bak.$(Get-Date -Format yyyyMMddHHmmss)"
    Say "Backing up existing config to $backup"
    Move-Item -Path $Dest -Destination $backup
  }
}

if (-not (Test-Path $Dest)) {
  Say "Cloning $RepoUrl"
  & git clone --depth 1 $RepoUrl $Dest
}

Say 'Bootstrapping plugins (headless, may take a minute)'
& nvim --headless "+Lazy! sync" +qa
if ($LASTEXITCODE -ne 0) { Warn 'plugin sync had errors; open nvim and run :Lazy sync' }

Say 'Done. Launch nvim - Mason will finish installing LSP servers on first start.'
Say 'Tip: use a Nerd Font (https://www.nerdfonts.com) in Windows Terminal for icons.'
