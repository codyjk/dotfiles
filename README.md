# Dotfiles

Managed by [chezmoi](https://www.chezmoi.io/). On `chezmoi init`, you choose which modules to install. chezmoi then applies only the files and tools for those modules.

## New Mac setup

1. Install the Xcode Command Line Tools. chezmoi needs git, and git is only a stub until this is done.
   ```
   xcode-select --install
   ```
2. Optional: to load API keys from 1Password, install the 1Password app and the 1Password CLI (use the `.pkg` installer). Sign in. Then answer yes to the 1Password question in step 3.
3. Install chezmoi and apply:
   ```
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply codyjk
   ```
4. Open a new terminal.

## Modules

| Module | Default | What it installs |
|---|---|---|
| `prompt` | on | powerlevel10k and `~/.p10k.zsh` |
| `fzf` | on | fzf binary and zsh key bindings |
| `nvim` | on | neovim, ripgrep, fd, nvim config, plugins from `lazy-lock.json` |
| `tmux` | on | tmux config. tmux itself is built from source into `~/.local` (about 2 minutes), or installed by Homebrew if `homebrew` is on |
| `terminal` | ghostty | Ghostty app, or `none` |
| `rust` | on | rustup and stable Rust (plus rust-analyzer with `nvim`) |
| `python` | on | uv and Python (plus pyright with `nvim`) |
| `node` | on | fnm and Node LTS (plus typescript with `nvim`) |
| `gh` | on | GitHub CLI |
| `secrets` | off | `~/.config/zsh/secrets.zsh` (mode 0600) from 1Password |
| `homebrew` | off | Homebrew in `/opt/homebrew` and `~/.Brewfile` |

Binaries come from pinned GitHub releases (see `.chezmoidata/versions.toml`) into `~/.local/bin`, not from Homebrew. To change a version, edit that file and run `chezmoi apply`.

To change your module choices, run `chezmoi init --prompt`, then `chezmoi apply`. Turning a module off stops managing its files. It does not uninstall anything.
