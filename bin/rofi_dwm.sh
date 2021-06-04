#! /usr/bin/bash
 rofi -show drun -run-shell-command '{terminal} -e \\"{cmd}; read -n 1 -s\\"'
