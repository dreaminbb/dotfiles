eval $(thefuck --alias)

eval "$(rbenv init -)"

# 最も標準的な設定
export FZF_DEFAULT_COMMAND='fd --type f'
# auto cd
setopt auto_cd

function chpwd() {
	lsd -l
}

function config() {
	# \ls と書くことで、alias設定を無視して生のlsコマンドを実行します
	# -1 (数字の1) をつけると、確実に1行1ファイル名になります
	local dir=$(\ls -1 ~/.config | fzf)

	# 何も選ばなかったら終了
	[ -z "$dir" ] && return

	# 移動して開く
	(cd "$HOME/.config/$dir" && nvim .)
}

function pj() {
	cd $HOME/Developer/$(ls $HOME/Developer | fzf)
	nvim
}

# complicate
autoload -Uz compinit
compinit

zstyle ':completion:*:default' menu select=1

# [MARK] OH-MY-ZSH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)"
# bun completions
[ -s "/Users/shin/.bun/_bun" ] && source "/Users/shin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# vi motion
bindkey -v

t-fzf() {
	tmux a -t $(tmux ls | cut -d: -f1 | fzf)
}

v-f() {
	nvim $(fzf)
}

alias g='git'
alias lg='lazygit'

alias wat="system_profiler SPPowerDataType | grep Wattage"
alias t="tmux"
alias cop='pbcopy'
alias update='brew update && brew upgrade  && brew cleanup && rustup update && bun upgrade'
alias py="python3"
alias pip="pip3"
alias ls='lsd -l'
alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias C="clear"
alias E="exit"
alias pl="picotool"
alias v="nvim"

# fzf の設定を読み込む
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# カスタム履歴検索ウィジェットを定義する例（より高度な設定）
# この例では、fcの出力から番号を削除してからfzfに渡しています。
fzf-history-widget() {
	local selected
	selected=$(fc -lnr 1 | fzf)
	if [ -n "$selected" ]; then
		BUFFER=$selected
		CURSOR=$#BUFFER
		zle redisplay
	fi
}
zle -N fzf-history-widget
bindkey '^r' fzf-history-widget

fzf-file-path() {
	# 明示的に find の結果を渡す
	local selected_file=$(find . -maxdepth 3 | fzf)

	if [ -n "$selected_file" ]; then
		LBUFFER+="$selected_file"
	fi
	zle reset-prompt
}

# Zshのラインエディタ(ZLE)に「ウィジェット」として登録
zle -N fzf-file-path

# キーバインドを設定
bindkey '^T' fzf-file-path

# Pico SDK
export PICO_SDK_PATH="$HOME/SDK/pico/pico-sdk"
export PATH="/opt/homebrew/opt/arm-gcc-bin@14/bin:$PATH"

export PATH="/Applications/ArmGNUToolchain/15.2.rel1/arm-none-eabi/bin:$PATH"

# Added by Antigravity CLI installer
export PATH="/Users/shin/.local/bin:$PATH"
export PATH="/Users/shin/.local/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"
