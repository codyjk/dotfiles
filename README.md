# Dotfiles

Managed by [chezmoi](https://www.chezmoi.io/). On `chezmoi init`, you choose which modules to install. chezmoi then applies only the files and tools for those modules.

## New Mac setup

1. Install the Xcode Command Line Tools. chezmoi needs git, and git is only a stub until this is done.
   ```
   xcode-select --install
   ```
2. Install chezmoi and apply. Answer no to the 1Password question for now.
   ```
   sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply codyjk
   ```
3. Open a new terminal.

### Optional: load API keys from 1Password

The `secrets` module reads keys with the 1Password CLI (`op`) when chezmoi applies, so install `op` first. This needs the `homebrew` module.

1. Install the 1Password app and sign in.
2. Install the CLI. The cask downloads 1Password's signed zip and checks its SHA-256.
   ```
   brew install --cask 1password-cli
   ```
3. Confirm the publisher. The output must be `TeamIdentifier=2BUA8C4S2C`.
   ```
   codesign -dv /opt/homebrew/bin/op 2>&1 | grep TeamIdentifier
   ```
4. In the 1Password app, turn on Settings > Developer > Integrate with 1Password CLI. Run `op whoami` to test it. On macOS 27, if `op` cannot reach the app, allow your terminal under System Settings > Privacy & Security > Files and Folders.
5. Run `chezmoi init --prompt`, answer yes to the 1Password question, then run `chezmoi apply`.

## Modules

| Module | Default | What it installs |
|---|---|---|
| `prompt` | on | powerlevel10k and `~/.p10k.zsh` |
| `fzf` | on | fzf binary and zsh key bindings |
| `nvim` | on | neovim, ripgrep, fd, nvim config, plugins from `lazy-lock.json` |
| `tmux` | on | tmux config. tmux itself is built from pinned source into `~/.local` (about 2 minutes), with or without Homebrew |
| `terminal` | ghostty | Ghostty app, or `none` |
| `rust` | on | rustup and a pinned Rust toolchain (plus rust-analyzer with `nvim`) |
| `python` | on | uv and Python (plus pyright with `nvim`) |
| `node` | on | fnm and a pinned Node LTS (plus typescript with `nvim`) |
| `gh` | on | GitHub CLI |
| `vale` | off | vale prose linter |
| `lathe` | off | lathe tutorial CLI, plus its skills in `~/.claude/skills` (reinstalled when the version changes) |
| `secrets` | off | `~/.config/zsh/secrets.zsh` (mode 0600) from 1Password |
| `homebrew` | off | Homebrew in `/opt/homebrew` and `~/.Brewfile` |

Binaries come from pinned GitHub releases (see `.chezmoidata/versions.toml`) into `~/.local/bin`, not from Homebrew. To change a version, edit that file and run `chezmoi apply`.

## Themes

`theme` switches the color theme and light/dark mode for Ghostty and Neovim in one step. Run `theme` for the list of themes. `quiet` is the default. Fourteen come from [vim-no-color-collections](https://github.com/mcchrish/vim-no-color-collections). A theme with only one variant uses it in every mode.

- `theme` shows the themes, marks the current one, and shows the mode.
- `theme NAME` switches to NAME. `theme next` goes to the next one.
- `theme dark`, `theme light`, or `theme auto` sets the mode. `auto` (the default) follows macOS.
- `theme NAME MODE` sets both.
- `theme preview [NAME...] [MODE]` draws a sample of each theme in the shell without switching. With no names, it shows all of them. `theme render` is the same command. It loads each colorscheme in headless Neovim, so the colors are exact.
- In Neovim, `:Theme` takes the same arguments. Both have tab completion.

The themes are listed in `~/.config/theme/themes`. The `theme` command and Neovim both read it. Your choice lives in `~/.local/state/theme`, outside chezmoi, so switching does not change the repo. Ghostty includes the `ghostty` file from that folder and reloads at once. Open Neovim instances switch at once. In auto mode, Neovim checks the macOS appearance when it gets focus. Italics are off in every colorscheme. tmux and p10k use ANSI colors, so they follow the Ghostty palette.

To add a theme:

1. Add a line to `dot_config/theme/themes`.
2. If Ghostty has no built-in theme for it, generate one from the Neovim colorscheme with `~/.config/theme/ghostty-from-nvim.lua` (usage is at the top of the file).
3. Add its Neovim plugin to `lua/plugins/colorscheme.lua`.
4. Run `chezmoi apply`.

## Pins and checksums

Every download has an exact version and a SHA-256 in `.chezmoidata/versions.toml`. chezmoi and the install scripts stop on a mismatch. This covers the binaries, powerlevel10k (pinned to one commit), the tmux source tarballs, rustup, and the Homebrew installer. Node, Python, Rust, pyright and TypeScript are also pinned to exact versions. rustup does not update itself. Ghostty must carry a valid signature from the Team ID in `versions.toml`.

To bump a version:

1. Change the version in `[versions]`.
2. Get the new hash from the GitHub release page ("digest"), or run `curl -fsSL <url> | shasum -a 256`.
3. Change the hash in `[checksums]`.
4. Run `chezmoi apply`.

## Homebrew controls

When the `homebrew` module is on:

- Homebrew installs from its signed `.pkg` at a pinned version, not from the `HEAD` install script.
- `~/.homebrew/brew.env` turns off analytics and auto-update, stops `brew install` from upgrading, forbids HTTPS-to-HTTP redirects, and requires a checksum for every cask. With the `gh` module on, it also verifies bottle attestations. Homebrew runs `gh` with its own PATH, so the bundle script and the `brew` wrapper pass the token from `gh auth token` in `HOMEBREW_GITHUB_API_TOKEN`. The token is never written to disk.
- `~/.Brewfile` is the complete list. `chezmoi apply` installs it with `--no-upgrade`, then runs `brew bundle cleanup --force`, which uninstalls anything not in it. The lists live in `.chezmoidata/packages.toml`. Each cask must have a checksum.
- `brewfile add NAME` and `brewfile remove NAME` edit those lists, run `chezmoi apply`, and commit the change. `brewfile add` checks that the package exists, uses the canonical name, and rejects casks with no checksum. Pass `--formula` or `--cask` when a name is both. `brewfile list` shows the lists.
- In zsh, `brew install` runs `brewfile add`, and `brew uninstall` / `remove` / `rm` run `brewfile remove`. `brew tap` and `brew fetch` are blocked (`fetch` caches bottles without an attestation check). Other `brew` commands run unchanged. To bypass, run `command brew ...`.
- `/opt/homebrew/bin` goes last on `PATH`, so Homebrew never shadows system tools or pinned tools.
- A Brewfile pins names, not versions. Homebrew packages change only when you run `brew update` and `brew upgrade`.

To change your module choices, run `chezmoi init --prompt`, then `chezmoi apply`. Turning a module off stops managing its files. It does not uninstall anything.
