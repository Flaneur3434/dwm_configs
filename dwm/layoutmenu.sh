#!/bin/sh

printf "[]= Tiled 0\n><> Floating 1\n[M] Monocle 2\n[@] Spiral 3\n[\\\\] Dwindle 4\n[D] Deck 5\n[DD] DoubleDeck 6\n[|+|] Tatami 7" | dmenu -i -nb "#cccccc" -nf "#000000" -sb "#0066ff" -sf "#ffffff" | cut -d ' ' -f 3
