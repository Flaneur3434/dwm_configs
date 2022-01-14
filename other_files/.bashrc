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

# functions

_checkexec() {
	command -v "$1" > /dev/null
}

ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#youtube-dl
alias youtube-dl="yt-dlp"
alias caprine='firejail --noprofile caprine'

#gpg
#verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
#receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

alias pacman='pacman --color auto'

if _checkexec pacman; then
    # General package management
    alias pSyu="sudo pacman -Syu"   # system upgrade
    alias pSyyu="sudo pacman -Syyu" # when updating mirrors
    alias pD="sudo pacman -D"       # set `--asdeps` or `--asexplicit`

    # Search remote database and download packages
    alias pSs="pacman -Ss"      # search remote for package
    alias pS="sudo pacman -S"   # sync download

    # Search local database
    alias pQs="pacman -Qs"      # query list
    alias pQmq="pacman -Qmq"    # list foreign packages
    alias pQdt="pacman -Qdt"    # list orphans

    # Inspect packages (remote and local)
    alias pSi="pacman -Si"      # remote package details
    alias pQi="pacman -Qi"      # local package details

    # Remove packages
    alias pRs="sudo pacman -Rs"     # remove package
    alias pRnsc="sudo pacman -Rnsc" # remove package recursively

    # Clear cache
    alias pScc='sudo pacman -Scc' #Cleanup orphaned packages
    alias cleanup='sudo pacman -Rns $(pacman -Qtdq)' #Cleanup orphaned packages

fi

alias ll='9 ls -l'
alias bashtop="btop"

## Colorize the grep command output for ease of use (good for log files)##
alias ftc_code='cd Documents/programming/Freight-Frenzy/TeamCode/src/main/java/org/firstinspires/ftc/teamcode'
alias ftc='cd Documents/programming/Freight-Frenzy/'
alias add_ftc='git add TeamCode/src/main/java/org/firstinspires/ftc/teamcode/'
alias ydown='cd ~/Videos/youtube'

alias running_service='systemctl list-units --type=service'

alias vim-his="grep '^>' .viminfo | cut -c3- | sed 's/~/\/home\/ken_nc\//'"
alias dfc='dfc -d'

# alias rsync='rsync -avuz'
# alias diskstation='ssh -vvv ken_nc@192.168.1.49 -p22' # for debugging
alias diskstation='ssh ken_nc@192.168.1.49 -p 22'
alias moto='ssh ken_nc@192.168.1.97 -p 8022'
alias Bind='sudo mount -t nfs 192.168.1.49:/volume2/backup /home/ken_nc/Documents/diskstation/'
alias UnBind='sudo unmount /home/ken_nc/Documents/diskstation/'
alias tpb='cd /home/ken_nc/Documents/diskstation/thinkpad_backup/'

alias iftop='sudo iftop -i wlan0'
alias yay='paru'

alias gp='grep -i -E'
alias ngp='grep -v -i'
# ngp 'git\|apue\|done\|received\|Freight-Frenzy\|sender\|actualDocuments' /tmp/rsync-log-file.txt
alias blog='blog.sh'
alias clock='plan9_clock'

alias clamscan='clamscan -vrz --bell --leave-temps --remove=yes'

alias fetch='fm6000 -de none -o Arch'
alias colortest='~/Downloads/color-scripts/color-scripts/colortest'
alias reset_clock='sudo timedatectl set-timezone UTC'

alias pl='. 91plumber &>/dev/null'
alias emda='emacs --daemon &'
alias tar_gz='tar -czvf' #tar czvf mydirectory.tgz mydirectory
alias notes='echo "/home/ken_nc/Documents/notes/linux_notes";echo; cat /home/ken_nc/Documents/notes/linux_notes'

# alias xterm='tabbed xterm -into'
alias em='sw emacsclient -c'
alias 9term='9term rc'
alias acme2='acme-start.sh'

# Git commands
# ------------

if _checkexec git; then
	export GIT_EDITOR="$EDITOR"

	# add, commit
	alias gadd='git add -v'
	alias gaddp='git add --patch'
	alias gaddi='git add --interactive'
	alias gall='git add -Av'
	alias gcom='git commit' # opens in the predefined editor.
	alias gcomm='git commit -m' # pass a message directly: gcomm 'My commit'
	alias gca='git commit --amend'
	alias grh='git reset HEAD'

	# stats and diffs
	alias gsh='git show'
	alias gsho='git show --oneline'
	alias glo='git log --oneline'
	alias glog='git log'
	alias gsta='git status'
	alias gstat='git status'
	alias gdif='git diff'
	alias gdiff='git diff'
	alias gdifs='git diff --stat --summary'
	alias gdiffss='git diff --stat --summary'
	alias gwc='git whatchanged'

	# branching
	alias gch='git checkout'
	alias gchb='git checkout -b'
	alias gbd='git branch -d'
	alias gbl='git branch --list'
	alias gpd='git push origin --delete'
	alias gmerg='git merge --edit --stat'
	alias gmerge='git merge --edit --stat'

	# tagging
	alias gtag='git tag --sign' # followed by the tag's name
	alias gtagl='git tag --list'

	# syncing
	alias gpull='git pull'
	alias gfetch='git fetch'
	alias gpm='git push -u origin master'
	alias gph='git push -u origin HEAD'
fi

9man ()
{
	walk /home/ken_nc/Downloads/websites/man.cat-v.org | gp "$1"
}

Ctags ()
{
  old_path="$PWD"

  while [[ ! -f TAGS && "$PWD" != "$HOME" ]]; do
      cd ..
  done

  if [[ -f tags ]]; then
      printf "\'tags\' file found in %s\n", $PWD
  else
  	echo "could not find tag file in $old_path"
    read -e -p "create tags?: " up

    if [[ $up == "y" || $up == "Y" ]]; then
      read -e -p "Language?: " lang
      cd "$old_path"
      ctags -f tags -R -n --languages="$lang" *
    fi
  fi
}

hive ()
{
    read -e -p "Enter hive number: " hive_num
    ssh "cs61c-adt@hive${hive_num}.cs.berkeley.edu"
}

mem_pid ()
{
	top -b -n 1 | gp "$1" | awk '{printf "%s G\t%s\n", $10/100*8, $12}'
}

by_size()
{
    du -sm * | sort -nr | head -10 | awk '{printf "%.2fG\t", $1/1024; $1=""; print $0}'
}

s ()
{
	9 ls | gp "$1"
}

convert_img ()
{
    read -e -p "Output Format(jpg / png): " o_format
    read -e -p "Input Format(webp / jpg / png): " i_format
    read -e -p "Current Directory: " current
    if [[ "$current" != "y" ]]; then
        read -e -p "Directory: " $directory
        cd $directory
    fi
    # magick mogrify -format JPEG -path OUTPUT *.webp
    if [[ $(ls | gp -c "$i_format$") -ge 1 ]]; then
        printf "Stand by ...\n"
        magick mogrify -format $o_format *.$i_format
        rm *.$i_format
    else
        echo "No $i_format file found"
    fi
    if [[ -n "$directory" ]]; then
        cd -
    fi
}

convert_vid ()
{
    read -e -p "Output Format(mp4 / webm): " o_format
    read -e -p "Input Format(m4v / mp4 / webm): " i_format
    read -e -p "Current Directory: " current
    if [[ "$current" == "y" ]]; then
        directory=$(pwd)
    else
        read -e -p "Directory: " directory
        cd $directory
    fi
    if [[ $o_format == $i_format ]]; then
        echo "input and output format is the same"
        return 0
    fi
    for vid_file in "$directory"/*
    do
        if [[ "$vid_file" =~ "$i_format" ]]; then
            vid_name=$(echo "$vid_file" | sed -nr "s/(.*)(\.$i_format)/\1/p")
            ffmpeg -i "$vid_file" "$vid_name.$o_format"
            rm "$vid_file"
        else
            echo "File(s) not found"
        fi
    done
    if [[ "$directory" != "$(pwd)" ]]; then
        cd -
    fi
}

gcc_w (){
    output_file=$(echo $1 | sed -nr "s/(.*)(\.c)/\1/p")
    gcc -Wall -Wextra -Wformat-security -Wswitch-default $1 -o $output_file
}

java-doc () {
  # openjdk-doc
  walk /usr/share/doc/java-openjdk/api | gp "$1"
}

figlet -f smslant "\$ whoami"
