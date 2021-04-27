#
# ~/.bashrc
#

#Ibus settings if you need them
#type ibus-setup in terminal to change settings and start the daemon
#delete the hashtags of the next lines and restart
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=dbus
#export QT_IM_MODULE=ibus

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Startx automatically
#if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

export HISTCONTROL=ignoreboth:erasedups

#PS1='[\u@\h \W]\$ '
export PS1="\[\e[31m\][\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[34m\]\h\[\e[m\] \[\e[35m\]\W\[\e[m\]\[\e[31m\]]\[\e[m\]\\$ "
#export PS1="\[\e[37m\]\W\[\e[m\] \[\e[34m\]|\[\e[m\]  "

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

#youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "

alias ytv-best="youtube-dl -f bestvideo+bestaudio "

#Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

#gpg
#verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
#receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

#shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
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

#create a file called .bashrc-personal and put all your personal aliases
#in there. They will not be overwritten by skel.

[[ -f ~/.bashrc-personal ]] && . ~/.bashrc-personal

backup ()
{
    # read -e -p "src: " src_dir
    # read -e -p "dest: " dest_dir
    youtube_src="/home/ken_nc/Videos/youtube/"
    youtube_dest="/volume2/backup/thinkpad_backup/youtube/youtube/"

    document_src="/home/ken_nc/Documents/"
    document_dest="/volume2/backup/thinkpad_backup/kennc_Doc/"

    download_src="/home/ken_nc/Downloads/"
    download_dest="/volume2/backup/thinkpad_backup/kennc_Down/"

    picture_src="/home/ken_nc/Pictures/"
    picture_dest="/volume2/backup/thinkpad_backup/kennc_Pic/"

    meme_src="/home/ken_nc/Videos/Memes/"
    meme_dest="/volume2/backup/thinkpad_backup/Memes/"

    echo "Back Up Youtube"
    echo "------------------------"
    rsync -avuz $youtube_src ken_nc@192.168.1.49:$youtube_dest
    echo "Back Up Memes"
    echo "------------------------"
    rsync -avuz $meme_src ken_nc@192.168.1.49:$meme_dest
    echo "Back Up Documents"
    echo "------------------------"
    rsync -avuz $document_src ken_nc@192.168.1.49:$document_dest
    echo "Back Up Downloads"
    echo "------------------------"
    rsync -avuz $download_src ken_nc@192.168.1.49:$download_dest
    echo "Back Up Pictures"
    echo "------------------------"
    rsync -avuz $picture_src ken_nc@192.168.1.49:$picture_dest
}

convert_img ()
{
    read -e -p "Output Format(jpg / png): " o_format
    read -e -p "Input Format(webp / jpg / png): " i_format
    read -e -p "Directory: " directory
    cd $directory
    # magick mogrify -format JPEG -path OUTPUT *.webp
    if [[ $(ls | grep -c "$i_format$") -ge 1 ]]; then
        magick mogrify -format $o_format *.$i_format
        rm *.$i_format
    else
        echo "No $i_format file found"
    fi
    cd -
}


export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:/usr/local/plan9/bin"
export PATH="$PATH:$HOME/go/bin/"
export PATH="$PATH:/usr/lib/jvm/java-11-openjdk/bin/"
export PATH="$PATH:$HOME/Documents/scripts/"

export EDITOR='nvim'
export VISUAL='nvim'
alias vi=nvim
#alias mv='mv -i'
#alias rm='rm -i'
alias pacman='pacman --color auto'
alias dhelp='cat ~/Downloads/dwm/config.h'
set -o vi
#list
# alias ls='ls --color=auto'
alias ls='exa'
alias la='exa -alh -G --header --git'
alias ll='ls -lh'

#fix obvious typo's
alias cd..='cd ..'
alias pdw="pwd"
alias udpate='sudo pacman -Syyu'
alias upate='sudo pacman -Syyu'

## Colorize the grep command output for ease of use (good for log files)##
alias pacman='pacman --color auto'
alias dhelp='cat ~/Downloads/dwm/config.h'
alias ftc_code='cd Documents/programming/Ultimate-Goal/TeamCode/src/main/java/org/firstinspires/ftc/teamcode'
alias ftc='cd Documents/programming/Ultimate-Goal/'
alias website='cd Documents/programming/html/school_website'
alias selfie='vlc v4l2:// :input-slave=alsa:// :v4l-vdev="/dev/video0"'
alias colortest='./Downloads/color-scripts/color-scripts/colortest'
alias get_dwm_conf='git clone https://github.com/GrapeJuiceSoda/dwm_configs.git'
alias get_dot_file='git clone https://github.com/GrapeJuiceSoda/Dotfiles.git'
alias running_service='systemctl list-units --type=service'
alias time_table='feh ~/Pictures/screenshots/time_table.jpg'
alias logout='pkill -KILL -u ken_nc'
alias untar="tar -xvzf"
alias himitsu="vi ~/Downloads/importantDocuments/.himitsu; keepassxc"
alias diskstation='ssh ken_nc@192.168.1.49 -p22'
# alias rsync='rsync -avuz'
# rsync ~/Videos/Memes ken_nc@192.168.1.47:/volume2/backup/thinkpad_backup/Memes
# scp volume2/backup/thinkpad_backup/Memes ken_nc@192.168.1.45:~/Videos/Memes/
alias uname='uname -nor'
alias iftop='sudo iftop -i wlan0'
alias yay='paru'
alias nb='newsboat'
#alias cat='bat'
alias grep='rg'
alias neofetch='pfetch'
alias blog='blog.sh'
alias clock='tty-clock -cs'
alias gb='go build -o /home/ken_nc/go/bin/'
alias bask='xdg-settings set default-web-browser basilisk.desktop'
alias libw='xdg-settings set default-web-browser librewolf.desktop'
alias clamscan='clamscan -vrz --bell --leave-temps --remove=yes'
alias df='dfc'
alias gcc_w='gcc -Wall -Wextra -Wformat-security -Wswitch-default'
wmname LG3D
#./Downloads/color-scripts/color-scripts/elfman
clear
# cat ~/Downloads/Ascii-Arts/gnu | lolcat
#user_info
echo ''
