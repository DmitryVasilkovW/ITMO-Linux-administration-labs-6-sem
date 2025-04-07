#!/bin/fish

top & set PID $last_pid
echo $PID | sudo tee "$CPU_SET_PATH/cpu0/tasks" >/dev/null
taskset -p $PID
