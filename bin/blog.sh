#!/bin/bash
# Enter src location
location="/home/ken_nc/.plzNo/.iSaidNo/.nooooo/blog_list"

no_tail(){
    read -e -p "What will you blog about: " var1
    echo "$(date) $var1" >> $location
}

if [[ $# == 0 ]]; then
    while [[ $flag != "n" ]]
    do
        no_tail
        read -e -p "Continue... " flag
            if [[ $flag =~ "n" ]]; then
                echo
                tail $location
                echo    
            fi
    done
    
else
    while [[ ! $# == 0 ]]
    do 
        case "$1" in
            -l)
                less $location
                ;;
            -s)
                no_tail
                ;;
            *)
                echo "Enter correct flags"
                ;;
        esac
        shift
    done
fi

exit 0
