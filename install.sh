#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# [リンク元 相対パス]:[リンク先 絶対パス]
TARGETS=(
    ".zshrc:${HOME}/.zshrc"
    ".config/nvim:${HOME}/.config/nvim"
    ".config/ghostty:${HOME}/.config/ghostty"
    ".tmux.conf:${HOME}/.tmux.conf"
)

echo "Setting up symlinks..."

for target in "${TARGETS[@]}"; do
    src_rel="${target%%:*}"
    dest="${target#*:}"
    src="${DOTFILES_DIR}/${src_rel}"

    # リンク元の存在確認
    if [[ ! -e "$src" ]]; then
        echo "Warning: Source not found: $src (Skipped)" >&2
        continue
    fi

    # リンク先の親ディレクトリ作成
    dest_dir="$(dirname "$dest")"
    if [[ ! -d "$dest_dir" ]]; then
        mkdir -p "$dest_dir"
    fi

    # 既存のシンボリックリンク以外のファイル/ディレクトリを退避
    if [[ -e "$dest" && ! -L "$dest" ]]; then
        backup="${dest}.backup.$(date +%Y%m%d%H%M%S)"
        echo "Backing up existing file: $dest -> $backup"
        mv "$dest" "$backup"
    fi

    # シンボリックリンク作成 (-s: symbolic, -n: treat symlink to dir as file, -f: overwrite)
    ln -snf "$src" "$dest"
    echo "Linked: $src -> $dest"
done

echo "Completed successfully."
