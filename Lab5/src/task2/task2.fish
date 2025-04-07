#!/bin/fish

sudo mkdir /sys/fs/cgroup/memory_test
echo "1170M" | sudo tee /sys/fs/cgroup/memory_test/memory.max >/dev/null

set pid (echo %self); echo $pid | sudo tee /sys/fs/cgroup/memory_test/cgroup.procs; tail /dev/zero &
