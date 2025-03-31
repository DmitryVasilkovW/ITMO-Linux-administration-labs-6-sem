#!/bin/bash

LOWER_DIR="/home/debian/overlay_/lower"
UPPER_DIR="/home/debian/overlay_/upper"
MERGED_DIR="/home/debian/overlay_/merged"
LOG_FILE="67_audit.log"

echo "=== Whiteout files in upper ===" > $LOG_FILE
find "$UPPER_DIR" -name '.wh.*' >> $LOG_FILE

echo -e "\n=== Difference between lower and merged ===" >> $LOG_FILE
diff -rq "$LOWER_DIR" "$MERGED_DIR" >> $LOG_FILE 2>&1

echo -e "\n=== Whiteout contents ===" >> $LOG_FILE
for file in $(find "$UPPER_DIR" -name '.wh.*'); do
  echo "File: $file" >> $LOG_FILE
  echo "Size: $(stat -c %s "$file") byte" >> $LOG_FILE
done

echo "Finished audit. Results available in $LOG_FILE"

chmod +x 67_audit.sh
./67_audit.sh
