#!/bin/bash
DIR=/Users/jonathanbouchet/TomTom\ MySports/Bilou
ls "$DIR"
for f in "$DIR"/*/*.ttbin
do
  echo "${f}"
  #python ttbindec.py "${f}"
  python ttbin_summary.py "${f}"
done