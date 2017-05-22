#!/bin/sh
tmux new-session -d -s 'scratchpad'
result=$?
if [ $result -eq 0 ]
then
	tmux split-window -h
fi
tmux attach-session -t 'scratchpad'
