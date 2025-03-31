set CPU_SET_PATH $(mount | grep cpuset | awk '{print $3}')

sudo mkdir "$CPU_SET_PATH/cpu0"

echo 0 | sudo tee "$CPU_SET_PATH/cpu0/cpuset.cpus"
echo 0 | sudo tee "$CPU_SET_PATH/cpu0/cpuset.mems"

cat "$CPU_SET_PATH/cpu0/cpuset.cpus"
cat "$CPU_SET_PATH/cpu0/cpuset.mems"
