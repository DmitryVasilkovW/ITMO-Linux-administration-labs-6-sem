sudo mkdir /sys/fs/cgroup/memory_test
echo "1170M" | sudo tee /sys/fs/cgroup/memory_test/memory.max >/dev/null

(echo $$ | sudo tee /sys/fs/cgroup/memory_test/cgroup.procs && tail /dev/zero) &
