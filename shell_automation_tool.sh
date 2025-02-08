#!/bin/bash

# Colaborators: MindCr, Lenam

delay=${2:-0.5}
actualkbmap=$(setxkbmap -query | grep 'layout' | tr -s ' ' ' ' | cut -d ' ' -f 2)

function ctrl_c(){
  setxkbmap $actualkbmap
  exit 1
}

trap ctrl_c SIGINT

setxkbmap us

wid=$(xdotool selectwindow)
xdotool windowactivate $wid

if [ "$1" == "script" ]; then
  xdotool type "script /dev/null -c bash"
elif [[ "$1" == *"php"* ]]; then
  xdotool type "$1 -r \"exec('/bin/bash');\""
elif [[ "$1" == *"python"* ]]; then
  xdotool type "$1 -c 'import pty;pty.spawn(\"/bin/bash\")'"
elif [[ "$1" == *"perl"* ]]; then
  xdotool type "$1 -e 'exec \"/bin/bash\";'"
elif [[ "$1" == *"ruby"* ]]; then
  xdotool type "$1 -e 'exec \"/bin/bash\"'"
else
  xdotool type "script /dev/null -c bash"
fi
xdotool key "Return"
sleep $delay
xdotool windowactivate $wid
xdotool key "Return" "ctrl+z"
sleep $delay
xdotool windowactivate $wid
xdotool type "stty raw -echo;fg"
xdotool key "Return"
sleep $delay
xdotool windowactivate $wid
xdotool type "reset xterm"
xdotool key "Return"
sleep $delay
xdotool windowactivate $wid
xdotool type "export TERM=xterm;export SHELL=bash"
xdotool key "Return"
sleep $delay

setxkbmap $actualkbmap

#xdotool type 'stty rows '$ROWS' columns '$COLUMNS
#xdotool key "Return"