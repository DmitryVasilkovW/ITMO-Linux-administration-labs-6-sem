#!/bin/bash

function show_menu() {
    clear
    echo "select action:"
    for i in {1..4}; do
        if [ $selected -eq $i ]; then
            echo "* $i. ${options[$i-1]} *"
        else
            echo "  $i. ${options[$i-1]}"
        fi
    done
}

pattern=task
path="${1:-.}"

function execute_script() {
    echo "enter number:"
    read script_number

    file="${pattern}${script_number}.sh"
    if [[ -f $file ]]; then
        full_path="$path/$file"
        bash "$full_path"
    else
        echo "$file not found"
    fi
}

function show_script() {
    echo "enter number:"
    read script_number
    
    file="${pattern}${script_number}.sh"
    if [[ -f $file ]]; then
        full_path="$path/$file"
        cat "$full_path"
    else
        echo "$file not found"
    fi
}

function execute_range() {
    echo "enter range:"
    read start end
    
    for ((i=start; i<=end; i++)); do
        file="${pattern}${i}.sh"
        if [[ -f $file ]]; then
            full_path="$path/$file"
            bash "$full_path"
        else
            echo "not found $file"
        fi
    done
}

function show_range() {
    echo "enter range:"
    read start end
    
    for ((i=start; i<=end; i++)); do
        file="${pattern}${i}.sh"
        if [[ -f $file ]]; then
            full_path="$path/$file"
            cat "$full_path"
        else
            echo "not found $file"
        fi
    done
}

selected=1

options=("execute script" "show script" "execute range" "show range" "exit")

while true; do
  show_menu

  stty -echo
  read -s -n 3 key
  stty echo

  case "$key" in
      $'\x1b[A')
          if [ $selected -gt 1 ]; then
              ((selected--))
          fi
          ;;
      $'\x1b[B')
          if [ $selected -lt 5 ]; then
              ((selected++))
          fi
          ;;
      "")
          case $selected in
            1) execute_script ;;
            2) show_script ;;
            3) execute_range ;;
            4) show_range ;;
            5) exit ;;
          esac
          ;;
  esac
done
