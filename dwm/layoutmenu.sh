#!/bin/sh

printf "[]= Tiled Layout 0\n><> Floating Layout 1\n[M] Monocle Layout 2\n[@] Spiral Layout 3\n[\\\\] Dwindle Layout 4" | dmenu -i -nb "#cccccc" -nf "#000000" -sb "#0066ff" -sf "#ffffff" | cut -d ' ' -f 4
