# Dotfiles

Personal Linux dotfiles managed with a bare Git repository.

## Installation

### Quick Start

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME '
dotfiles clone --bare https://github.com/avetruvio/config.git ~/.dotfiles
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

After setup, use `dotfiles pull` to update. If you've forked the repository, you can use `dotfiles status`, `dotfiles add`, `dotfiles commit`, and `dotfiles push` as usual.

To remove `~/readme.md` from your home directory without it returning on future pulls:

```bash
dotfiles update-index --assume-unchanged ~/readme.md
rm ~/readme.md
```

### How the Bare Repo Works

1. **Alias (`dotfiles`)**: Points Git to `~/.dotfiles` as the git directory and `$HOME` as the work tree, so dotfiles can be tracked anywhere under `$HOME` without making `$HOME` a normal git working tree.
2. **Clone (`--bare`)**: Clones only the git metadata into `~/.dotfiles`.
3. **Checkout**: Places the tracked files into `$HOME`. If existing config files conflict, Git will list them and abort; move or remove those files before re-running `dotfiles checkout`.
4. **Hide Untracked Files**: `status.showUntrackedFiles no` prevents `dotfiles status` from listing every untracked file in `$HOME`.

---

## Repository Structure

### Shell & X11

| File | Purpose |
| :--- | :--- |
| `.profile` | Login shell environment: adds `~/.local/bin` and Android `platform-tools` to `PATH`, sets `XDG_CONFIG_HOME` / `XDG_DATA_HOME` / `VIMINIT`, and sources `.bashrc`. |
| `.bashrc` | Interactive Bash setup: history settings, `parse_git_branch` colored prompt, `dircolors`/`LS_COLORS`, `vi` editing mode (`set -o vi`), `TERMINFO_DIRS`, and sourcing of `~/.config/bash/aliases`. |
| `.config/bash/aliases` | Custom aliases and functions (`dotfiles`, `cd` with `ls -F`, `hist`, `open`, `rmd`, `clock`, `timer`, etc.). |
| `.xprofile` | X11 session startup: swaps Caps Lock and Escape (`setxkbmap`), runs `i3-build.sh` if `i3` is installed, and starts `dunst`. |
| `.Xresources` | X11 terminal colors, alpha/transparency, `URxvt` font stack, and `PrintScreen` print-pipe disable. |

### Window Manager & Status

| File | Purpose |
| :--- | :--- |
| `.config/i3/i3-build.sh` | Concatenates `base.part` and `generic.part` into `~/.config/i3/config`, creates `~/Pictures/screencaps`, and appends `i3-nagbar` warnings for missing dependencies. |
| `.config/i3/base.part` | Core i3 configuration: startup daemons, keybindings, resize mode, media/brightness keys, and screenshot bindings. |
| `.config/i3/generic.part` | Workspace definitions (`1`–`10`) and workspace switching/move bindings. |
| `.config/i3/compton.cfg` | Compton compositor settings (shadows, opacity, fading, `xrender` backend). |
| `.config/i3status/config` | `i3status` bar modules: disk (`/`), wireless, ethernet, VPN (`/proc/sys/net/ipv4/conf/tun0`), battery, load, `cpu_usage`, ALSA volume, and local time. |

### Terminal, Multiplexer, Editor & System

| File | Purpose |
| :--- | :--- |
| `.config/termite/config` | Termite terminal font (`Monospace 9`), 10k scrollback, translucent background, and color palette. |
| `.config/terminfo/x/xterm-termite` | Compiled terminfo entry for `xterm-termite`. |
| `.config/tmux/config` | `tmux` configuration: `C-a` prefix, `v`/`h` pane splits, `Alt+Arrow` pane navigation, and config reload. |
| `.config/vim/vimrc` | Vim settings: 2-space indentation, line numbers, syntax/filetype plugins, and XDG-based `undo`/`swap`/`backup`/`viminfo` directories. |
| `.config/vim/ftdetect/markdown.vim` | Associates `*.markdown`, `*.md`, and `*.mkd` with the `markdown` filetype. |
| `.config/vim/ftplugin/markdown.vim` | Buffer-local Markdown settings: wrapping, spellcheck (`en_us`), folding helper (`MarkdownFold`), and hidden line numbers. |
| `.config/htop/htoprc` | `htop` layout, meters, and color scheme. |

### Scripts & Data

| File | Purpose |
| :--- | :--- |
| `.local/bin/chbg` | Picks a random wallpaper from `~/Pictures/backgrounds/` and sets it via `feh`. |
| `.local/bin/dmenuunicode` | Prompts for an emoji from `~/.local/share/dotfiles/emoji` via `dmenu` and types it (`xdotool`) or copies it to the clipboard (`xclip`). |
| `.local/share/dotfiles/autostart.sh` | Parses `[Desktop Entry]` `Exec=` lines from `~/.config/autostart/*.desktop`, strips field codes, and launches them in the background. |
| `.local/share/dotfiles/emoji` | Emoji lookup table used by `dmenuunicode`. |

---

## Keybindings

### i3 (`Mod4` = Super)

| Binding | Action |
| :--- | :--- |
| `Mod4 + Return` | Open terminal (`i3-sensible-terminal`) |
| `Mod4` (tap/release) | Launch `i3-dmenu-desktop` |
| `Mod4 + b` | Launch `brave-browser` |
| `Mod4 + u` | Emoji picker (`dmenuunicode`) |
| `Mod4 + q` | Kill focused window |
| `Mod4 + f` | Toggle fullscreen |
| `Mod4 + w` / `s` / `e` | Tabbed / stacking / toggle-split layout |
| `Mod4 + h` / `v` | Split horizontal / vertical |
| `Mod4 + j/k/l/;` or `Arrows` | Focus left / down / up / right |
| `Mod4 + Shift + j/k/l/;` or `Arrows` | Move window left / down / up / right |
| `Mod4 + r` | Enter resize mode (`Esc` or `Return` to exit) |
| `Mod4 + Space` / `Shift+Space` | Toggle focus / toggle floating |
| `Mod4 + -` / `Shift + -` | Show scratchpad / move to scratchpad |
| `Mod4 + 1..0` | Switch to workspace `1`–`10` |
| `Mod4 + Shift + 1..0` | Move container to workspace `1`–`10` |
| `Mod4 + c` / `Shift + r` | Reload config / restart i3 in place |
| `Mod4 + x` / `z` | Lock screen (`light-locker-command -l`) / suspend |
| `Mod4 + Shift + x` | Exit i3 prompt |
| `Print` | Area screenshot to `~/Pictures/screencaps/` + clipboard |
| `Shift + Print` | Full-screen screenshot to `~/Pictures/screencaps/` + clipboard |
| `XF86Audio*` / `XF86MonBrightness*` | Volume (`pactl`), media (`playerctl`), brightness (`xbacklight`) |

### tmux (`C-a` Prefix)

| Binding | Action |
| :--- | :--- |
| `C-a v` / `C-a h` | Split pane horizontally / vertically in current path |
| `Alt + Arrow` | Switch panes without prefix |
| `C-a r` | Reload `~/.config/tmux/config` |

---

## Shell Aliases & Functions

- `dotfiles` — Bare git wrapper for managing `$HOME` dotfiles
- `ll` / `la` / `l` — `ls -alF` / `ls -A` / `ls`
- `cd` — Changes directory and runs `ls -F`
- `tmux` — Runs `tmux -2 -f ~/.config/tmux/config`
- `vi` — Aliased to `vim` when `/usr/bin/vim` is present
- `hist` — Last 10 history entries (`history | tail -n 10`)
- `alert` — Desktop notification for long-running commands (`notify-send`)
- `open` — `xdg-open`
- `rmd <file.md>` — Renders Markdown in terminal using `pandoc` and `w3m`
- `clock` / `timer` — `tty-clock` / `tty-countdown` (when installed)

---

## Dependencies

- **Core WM / Desktop**: `i3`, `i3status`, `dmenu`, `compton`, `feh`, `light-locker`, `dunst`
- **Terminals & CLI**: `rxvt-unicode` (`urxvt`) or `termite`, `tmux`, `vim`, `htop`
- **Utilities**: `xclip`, `xdotool`, `imagemagick` (`import`), `pulseaudio-utils` (`pactl`), `playerctl`, `xbacklight`, `pandoc`, `w3m`
