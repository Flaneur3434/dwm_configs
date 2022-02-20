#!/bin/sh
# Script by Ypnose - http://ywstd.fr

DIR="/usr/share/fonts"
FONTDIR="${DIR}/envypn"

if [ "$1" = "-h" ]; then
	printf "%s\n" "usage: ${0##*/} [-h] [directory]"
	printf "%s\n" "    directory: change the font directory (default is $FONTDIR)"
	exit 0
fi

if [ -n "$1" ]; then
	if [ -d "$1" ]; then
		DIR="$1"
		FONTDIR="${DIR}/envypn"
	else
		printf "%s\n" "$1 doesn't exist!" >&2
		exit 1
	fi
fi

if [ ! -w "$DIR" ]; then
	printf "%s\n%s\n" "No write permissions in $DIR." \
		"You need to change the location accordingly." >&2
	exit 1
fi
[ ! -d "$FONTDIR" ] && mkdir "$FONTDIR"
cp *.pcf.gz fonts.alias README "$FONTDIR"
if [ $? -eq 0 ]; then
	fc-cache "$FONTDIR"
	mkfontdir "$FONTDIR"
	printf "%s\n%s\n" "envypn is successfully installed!" \
		"You may take a look at the README in $FONTDIR"
else
	printf "%s\n" "An error occurred" >&2
	exit 1
fi

exit
