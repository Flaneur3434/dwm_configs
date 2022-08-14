#
# ~/.bash_profile
#
[ -f ~/.profile ] && . ~/.profile

# opam configuration
test -r /home/ken_nc/.opam/opam-init/init.sh && . /home/ken_nc/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
