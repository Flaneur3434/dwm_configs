#
# ~/.bash_profile
#

export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_AWT_WM_NONREPARENTING=1

export HISTCONTROL=ignoreboth:erasedups
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:/usr/local/plan9/bin"
export PATH="$PATH:$HOME/go/bin/"
export PATH="$PATH:/usr/lib/jvm/java-11-openjdk/bin/"
export PATH="$PATH:$HOME/Documents/scripts/"

export EDITOR='nvim'
export VISUAL='nvim'

# opam configuration
test -r /home/ken_nc/.opam/opam-init/init.sh && . /home/ken_nc/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
