sudo unshare --mount bash
mkdir /tmp/private_$(whoami)
mount -t tmpfs tmpfs /tmp/private_$(whoami)
