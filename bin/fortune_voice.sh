#! /usr/bin/fish
set text (fortune)

echo $text; flite -voice slt --setf int_fo_target_mean=400 --setf duration_stretch=1.25 -t $text > /dev/null;
