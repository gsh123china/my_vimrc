#!/bin/bash
"/mnt/d/Program Files/Araxis/Araxis Merge/Merge.exe" "$(wslpath -w "$1")" "$(wslpath -w "$2")"

