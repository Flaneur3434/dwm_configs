# [ -f ~/.profile ] && . ~/.profile

shopt -s checkwinsize globstar complete_fullquote extquote extglob\
     force_fignore hostcomplete interactive_comments xpg_echo promptvars\
     sourcepath progcomp autocd cdspell dirspell direxpand nocasematch\
     histappend cmdhist lithist

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [[ -f "/etc/profile.d/bash-completion.sh" ]] ;
   then source /etc/profile.d/bash-completion.sh
fi

if [ -e $HOME/.alias ]; then
	source $HOME/.alias
fi

if [ -e $HOME/.profile ]; then
	source $HOME/.profile
fi

# overwrite some stuff for 9term
if [ "$TERM" == "dumb" ]; then
    alias ls='ls --color=never'
    alias grep='grep --color=never'
    export PAGER=cat
    export GIT_PAGER=cat
	export PS1="% "
fi

bind -x '"\eOP":"91plumber $PWD && cd $PWD/$(xclip -o)"'
# Ctrl-(left/right arrow)
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'
# figlet -f smslant "\$ whoami"

set -o emacs
