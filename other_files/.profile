export PS1="\[\e[31m\][\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[34m\]\h\[\e[m\] \[\e[35m\]\W\[\e[m\]\[\e[31m\]]\[\e[m\]\\$ "
#export PS1="\[\e[37m\]\W\[\e[m\] \[\e[34m\]|\[\e[m\]  "
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_AWT_WM_NONREPARENTING=1

export HISTCONTROL=ignoreboth:erasedups
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/Documents/scripts/"
export PATH="$PATH:$HOME/Documents/scripts/x11-scripts"
export PATH="$PATH:$HOME/Documents/scripts/rdumpfs"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/go/bin/"
export PATH="$PATH:/usr/lib/jvm/java-11-openjdk/bin/"
# goes at the end of $PATH
export PATH="$PATH:/usr/local/plan9/bin"

export LD_LIBRARY_PATH="/home/ken_nc/.local/share/lutris/runners/wine/lutris-7.2-2-x86_64/lib64/gstreamer-1.0/"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/ken_nc/.local/share/lutris/runners/wine/lutris-7.2-2-x86_64/lib/gstreamer-1.0/"

# export EDITOR='emacsclient -t'
# export VISUAL='emacsclient -t'
export TERM='xterm-direct'
export EDITOR='emacsclient -t'
export VISUAL='emacsclient -c -a emacs'
export COLORTERM='truecolor'
export BROWSER='librewolf'
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
# export LESS=' --hilite-search --ignore-case --long-prompt --mouse --RAW-CONTROL-CHARS  '
export LESS=' --hilite-search --ignore-case --long-prompt --RAW-CONTROL-CHARS  '
export PAGER='less'

# more performant emacs lsp
export LSP_USE_PLISTS=true
export PLAN9=/usr/local/plan9 export PLAN9

# bash reverse search forward keybind works
stty -ixon

[[ -f /home/ken_nc/Documents/scripts/bashmarks.sh ]] && source /home/ken_nc/Documents/scripts/bashmarks.sh
[[ -f /home/ken_nc/.dir_colors ]] && eval $( dircolors -b $HOME/.dir_colors )
