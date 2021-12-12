PATH="/home/benedict/.local/bin:$PATH"

# Not an interactive shell? Time to leave...
[ -z "$PS1" ] && return

if test -z "$STY" && command -v screen >/dev/null 2>/dev/null
then
	source ~/.config/zsh-functions/screen-select
	screen-select && return
fi

# Options
setopt autocd
setopt extendedglob
setopt no_bg_nice
setopt nomatch
setopt ksh_autoload
setopt noflowcontrol

# History configuration
setopt appendhistory
setopt sharehistory
HISTFILE=~/.config/zsh-history/default
HISTSIZE=5000
SAVEHIST=5000

# Custom functions & other auto-loads
autoload -Uz add-zsh-hook
autoload -U colors && colors -u 2>/dev/null

# Input controls
bindkey -e
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word

export EDITOR="vim"
export COLORFGBG="default;default"

source ~/.config/zsh-functions/aliases
source ~/.config/zsh-functions/compinit
source ~/.config/zsh-functions/prompt
source ~/.config/zsh-functions/python
command -v git     >/dev/null 2>/dev/null && source ~/.config/zsh-functions/git
command -v kubectl >/dev/null 2>/dev/null && source ~/.config/zsh-functions/kube

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

set_prompt
