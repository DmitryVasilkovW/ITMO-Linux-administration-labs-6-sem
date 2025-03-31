top & PID=$!
echo $PID | sudo tee "$CPU_SET_PATH/cpu0/tasks" >/dev/null
taskset -p $PID
