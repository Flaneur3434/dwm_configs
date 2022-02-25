[ -f ~/.profile ] && . ~/.profile

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

# overwrite some stuff for 9term
if [ "$TERM" == "dumb" ]; then
    alias ls='ls --color=never'
    alias grep='grep --color=never'
    export PAGER=cat
    export GIT_PAGER=cat
	export PS1="% "
fi

# figlet -f smslant "\$ whoami"
