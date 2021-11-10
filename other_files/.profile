export PS1="\[\e[31m\][\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[34m\]\h\[\e[m\] \[\e[35m\]\W\[\e[m\]\[\e[31m\]]\[\e[m\]\\$ "
#export PS1="\[\e[37m\]\W\[\e[m\] \[\e[34m\]|\[\e[m\]  "
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_AWT_WM_NONREPARENTING=1

export HISTCONTROL=ignoreboth:erasedups
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:/usr/local/plan9/bin"
export PATH="$PATH:$HOME/go/bin/"
export PATH="$PATH:/usr/lib/jvm/java-11-openjdk/bin/"
export PATH="$PATH:$HOME/Documents/scripts/"
export PATH="$PATH:$HOME/Documents/scripts/acme_scripts/"

export EDITOR='vim'
export VISUAL='vim'
PLAN9=/usr/local/plan9 export PLAN9

export QT_GRAPHICSSYSTEM=native
# opam configuration
test -r /home/ken_nc/.opam/opam-init/init.sh && . /home/ken_nc/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
