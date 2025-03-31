sudo unshare --pid --fork bash
mount -t proc proc /proc

ps aux
