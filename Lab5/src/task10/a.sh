mkdir -p ~/overlay_/{lower,upper,work,merged}

echo "Оригинальный текст из LOWER" > ~/overlay_/lower/67_original.txt

sudo mount -t overlay overlay \
  -o lowerdir=/home/debian/overlay_/lower,\
upperdir=/home/debian/overlay_/upper,\
workdir=/home/debian/overlay_/work \
  /home/debian/overlay_/merged

ls ~/overlay_/merged
