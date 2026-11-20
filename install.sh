#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/avetruvio/config.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/.dotfiles-backup}"
FORCE=0

usage() {
	cat <<'EOF'
Usage: install.sh [-f|--force] [-h|--help]

Installs the dotfiles bare Git repository into ~/.dotfiles and checks out
tracked files into $HOME. Existing ~/.bashrc, ~/.profile, and any other
conflicting files are moved to ~/.dotfiles-backup (or deleted with -f).
EOF
}

while [ "$#" -gt 0 ]; do
	case "$1" in
		-f|--force)
			FORCE=1
			shift
			;;
		-h|--help)
			usage
			exit 0
			;;
		*)
			echo "Unknown option: $1" >&2
			usage >&2
			exit 1
			;;
	esac
done

if ! command -v git >/dev/null 2>&1; then
	echo "Error: git is required to install dotfiles." >&2
	exit 1
fi

dotfiles() {
	git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

if [ -d "$DOTFILES_DIR" ]; then
	echo "Using existing bare repository at $DOTFILES_DIR"
else
	echo "Cloning $REPO_URL into $DOTFILES_DIR..."
	git clone --bare "$REPO_URL" "$DOTFILES_DIR"
fi

# Remove or back up existing .bashrc and .profile (and any other conflicting tracked files)
handle_conflict() {
	local rel_path="$1"
	local target="$HOME/$rel_path"
	if [ -e "$target" ] || [ -L "$target" ]; then
		if [ "$FORCE" -eq 1 ]; then
			rm -rf "$target"
			echo "Removed existing $target"
		else
			mkdir -p "$BACKUP_DIR/$(dirname "$rel_path")"
			mv "$target" "$BACKUP_DIR/$rel_path"
			echo "Backed up $target -> $BACKUP_DIR/$rel_path"
		fi
	fi
}

handle_conflict ".bashrc"
handle_conflict ".profile"

# Back up or remove any remaining tracked files that already exist in $HOME
while IFS= read -r file; do
	[ -z "$file" ] && continue
	handle_conflict "$file"
done < <(dotfiles ls-tree -r --name-only HEAD)

echo "Checking out dotfiles into $HOME..."
dotfiles checkout -f
dotfiles config --local status.showUntrackedFiles no

# Ensure helper scripts are executable
chmod +x \
	"$HOME/.config/i3/i3-build.sh" \
	"$HOME/.local/bin/chbg" \
	"$HOME/.local/bin/dmenuunicode" \
	"$HOME/.local/share/dotfiles/autostart.sh" 2>/dev/null || true

echo "Dotfiles installed successfully."
if [ "$FORCE" -eq 0 ] && [ -d "$BACKUP_DIR" ]; then
	echo "Previous conflicting files were saved to $BACKUP_DIR"
fi
