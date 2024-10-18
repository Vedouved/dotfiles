#!/bin/bash

cd ~/Pictures/Wallpapers/.
while : ; do
   file="$(ls *.jpg | sort -R | tail -1)"
   swww img "$file" --transition...
   wal -i $file -n
   sleep 3600
done
