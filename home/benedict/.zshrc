# Not an interactive shell? Time to leave...
[ -z "$PS1" ] && return

# First, make sure we're running in a screen session
if [ -z "$STY" ]
then
	if command -v screen >/dev/null 2>/dev/null
	then
		source /home/benedict/.screen-select && screen-select && return
	else
		printf "Warning: unable to automatically load screen\n"
	fi
fi

# Options
setopt autocd
setopt extendedglob
setopt no_bg_nice
setopt nomatch
setopt ksh_autoload
setopt noflowcontrol

# Custom functions & other auto-loads
autoload -U compinit && compinit -u 2>/dev/null
autoload -U colors && colors 2> /dev/null
autoload chmog

# Input controls
bindkey -e
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
alias ':q=exit'

# Make sure emacs can never return
export EDITOR="vim"

# History configuration
setopt appendhistory
setopt sharehistory
HISTFILE=~/.zsh-history
HISTSIZE=1000
SAVEHIST=1000

# Beep command
# Hang over from my time with dos
# Used a lot to notify after long tasks...
alias beep="echo -en '\007'"

# Enable color where supported
command -v dircolors >/dev/null 2>&1 && dircolors -b

alias 'ls=ls --color=auto'
alias 'grep=grep --colour=auto'

export COLORFGBG='default;default'

# Short command aliases
chmog()
{
	printf "zsh: kitteh not found: $2\n"
}

l()
{
	command ls -h -l --color=always $* | more
}

ll()
{
	find $* exec ls -ld --color=always '{}' \+ | more
}

alias 'lk=l -A'

# Pedantry
alias 'whom=who'
alias 'whence=which' # no, really. From where it comes - the full path

#---COMPLETION STUFF------------------------------------------------------
zstyle ':completion:*' verbose yes
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zshcache
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd

zstyle ':completion::*:(rm|vim):*' ignore-line true
zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.o' '*.pdf'
zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.aux' '*.dvi' '*.out' '*.nav' '*.snm'

#---PROMPT STUFF----------------------------------------------------------

# <user>@<host>:<cwd>$
export PS1="%{$fg_bold[yellow]}%}%n@%m%{$fg[white]%}:%{$fg_bold[blue]%}%5c%{$reset_color%}\$ "

