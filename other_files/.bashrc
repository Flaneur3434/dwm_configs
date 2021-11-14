[ -f ~/.profile ] && . ~/.profile

set -o vi

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

backup ()
{
    # read -e -p "src: " src_dir
    # read -e -p "dest: " dest_dir
    youtube_src="/home/ken_nc/Videos/youtube/"
    youtube_dest="/volume2/backup/thinkpad_backup/kennc_Vid/youtube/"

    document_src="/home/ken_nc/Documents/"
    document_dest="/volume2/backup/thinkpad_backup/kennc_Doc/"

    download_src="/home/ken_nc/Downloads/"
    download_dest="/volume2/backup/thinkpad_backup/kennc_Down/"

    picture_src="/home/ken_nc/Pictures/"
    picture_dest="/volume2/backup/thinkpad_backup/kennc_Pic/"

    meme_src="/home/ken_nc/Videos/Memes/"
    meme_dest="/volume2/backup/thinkpad_backup/kennc_Vid/Memes/"

    recordings_src="/home/ken_nc/Videos/recordings/"
    recordings_dest="/volume2/backup/thinkpad_backup/kennc_Vid/recordings/"

  	desktop_src="/home/ken_nc/Desktop/"
    desktop_dest="/volume2/backup/thinkpad_backup/kennc_Desktop/"

  	music_src="/home/ken_nc/Music/"
    music_dest="/volume2/backup/thinkpad_backup/kennc_Music/"

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
    echo "Back Up Recordings"
    echo "------------------------"
    rsync -avuz $recordings_src ken_nc@192.168.1.49:$recordings_dest
  	echo "Back Up Desktop"
    echo "------------------------"
    rsync -avuz $desktop_src ken_nc@192.168.1.49:$desktop_dest
  	echo "Back Up Music"
    echo "------------------------"
    rsync -avuz $music_src ken_nc@192.168.1.49:$music_dest
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
    if [[ $(ls | grep -c "$i_format$") -ge 1 ]]; then
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

# search
s ()
{
	ls -a | grep -i -E "$1"
}

#youtube-dl
# alias yta-aac="youtube-dl --extract-audio --audio-format aac "
# alias yta-best="youtube-dl --extract-audio --audio-format best "
# alias yta-flac="youtube-dl --extract-audio --audio-format flac "
# alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
# alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
# alias yta-opus="youtube-dl --extract-audio --audio-format opus "
# alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
# alias yta-wav="youtube-dl --extract-audio --audio-format wav "
# alias ytv-best="youtube-dl -f bestvideo+bestaudio "
alias youtube-dl="yt-dlp"



#gpg
#verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
#receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

alias vi=nvim

alias pacman='pacman --color auto'
#Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

alias dhelp='cat ~/Downloads/dwm/config.h'

#list
# alias ls='exa'
# alias la='exa -alh -G --header --git'
# alias ll='ls -lh'
alias ll='lc'

# can pipe into more or something
alias mn="man -P cat"

alias bashtop="btop"
by_size()
{
    du -sm * | sort -nr | head -10 | awk '{printf "%.2fG\t", $1/1024; $1=""; print $0}'
}

## Colorize the grep command output for ease of use (good for log files)##
alias ftc_code='cd Documents/programming/Ultimate-Goal/TeamCode/src/main/java/org/firstinspires/ftc/teamcode'
alias ftc='cd Documents/programming/Ultimate-Goal/'
alias website='cd Documents/programming/html/school_website'
alias colortest='./Downloads/color-scripts/color-scripts/colortest'
alias cs61c='cd Documents/programming/cs61c/'

alias running_service='systemctl list-units --type=service'
alias time_table='feh ~/Pictures/screenshots/time_table.jpg'
# alias diskstation='ssh -vvv ken_nc@192.168.1.49 -p22' # for debugging
alias diskstation='ssh ken_nc@192.168.1.49 -p22'
alias ydown='cd ~/Videos/youtube'

hive ()
{
    read -e -p "Enter hive number: " hive_num
    ssh "cs61c-adt@hive${hive_num}.cs.berkeley.edu"
}

mem_pid ()
{
	top -b -n 1 | grep "$1" | awk '{printf "%s G\t%s\n", $10/100*8, $12}'
}

# alias rsync='rsync -avuz'

alias iftop='sudo iftop -i wlan0'
alias yay='paru'

alias grep='grep -i -E'
alias blog='blog.sh'
alias clock='plan9_clock'

alias clamscan='clamscan -vrz --bell --leave-temps --remove=yes'

alias fetch='fm6000 -de none -o Arch'
alias colortest='~/Downloads/color-scripts/color-scripts/colortest'
alias reset_clock='sudo timedatectl set-timezone UTC'

alias pl='. 91plumber'
alias tar_gz='tar -czvf' #tar czvf mydirectory.tgz mydirectory

alias logisim='java -jar ../tools/logisim-evolution.jar'

# alias xterm='tabbed xterm -into'
alias em='emacsclient -c'
alias 9term='9term rc'
alias acme2='acme-start.sh'
9man ()
{
	walk /home/ken_nc/Downloads/websites/man.cat-v.org | grep "$1"
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

#cheatsheet
# xdg-settings set default-web-browser brave-browser.desktop
# xdg-settings set default-web-browser librewolf.desktop

# rsync ~/Videos/Memes ken_nc@192.168.1.47:/volume2/backup/thinkpad_backup/Memes
# scp volume2/backup/thinkpad_backup/Memes ken_nc@192.168.1.45:~/Videos/Memes/

# memory usage -------
# ps -o pid,user,%mem,command ax | sort -b -k3 -r | grep "btop" | awk '{printf "%s G\t%s\n", $3*8, $4}'
# /* get the memory useage of a specific prossess, in this case btop */

# find files -------
# walk ~/Documents/programming/C | grep '\.c$' | xargs g '^main'
# /* find all files that end with .c in ~/Documents/programming/C and print the file and the line number with the pattern '^main'
# walk | grep "\.\/[a-zA-Z0-9]*" | xargs cat

# CTAGS search -------
# ctags -f TAGS_XREF -R -x *
# /* create ctags but human readable format */
# cat TAGS_XREF | grep "^object\s+" | awk '{printf "%s:%s\n", $4, $3}'
# Plan9 Style
# grep '^mailmap_entry' TAGS_XREF | awk '{printf "%s:%s\n", $4, $3}'
# /* print out file:line_num in dictionary order */

# Aspell -------
# aspell -l en_EN -c draft.txt
# /* With this command, aspell will make an interactive display in the terminal */

# Diskstation
# From the web browser
# https://192.168.1.49:5001/

# Pacman
# sudo pacman -Rns $(pacman -Qtdq) - Remove orphan packages
# sudo pacman -Scc - Remove package caches
# yay -Scc - Remove package caches

# iwctl connect to wifi
# ip link set wlan0 up
# station wlan0 scan
# station wlan0 get-networks
# station wlan0 connect HOME-16EC-5
# DO Staff: Educati0n!!

# NetworkManager connect to wifi
# You can't use iwctl+dhcpcd and Network Manager at the same time
# sudo systemctl start NetworkManager.service
# sudo systemctl start systemd-resolved.service
# use nm-applet to connect to wifi

# TLP (battery saver)
# get tlp.conf from github
# run sudo tlp start
# And look at the errors

# NFS mounting
# sudo mount 192.168.1.49:/volume2/backup /home/ken_nc/Documents/diskstation/

clear
# echo "ken_ncです。よろしくお願いします。"
# echo "δωρεάν λαγουδάκι"
# echo "бесплатный кролик"
# echo "免費的兔子"
# echo glenda gang 9 | figlet -f smslant
figlet -f smslant "\$ whoami"
echo ''
# cat ~/Documents/asciiArt/glenda
