#!/bin/bash

clear

# List all .sh files in the current directory, excluding the script itself
script_name=$(basename "$0")

# List all .sh files in the current director
sh_files=$(ls *.sh | grep -v "$script_name")

# Check if there are any .sh files
if [ -z "$sh_files" ]; then
  echo "No .sh files found in the current directory."
  exit 1
fi

# Prompt the user to select a .sh file
echo "ShellGB - Run shell scripts in the background"
echo "by Rodrigo Ramos - github.com/rodrigoramosrs/ShellBG"

echo # new line here =) 
echo "Select a .sh file to execute in background:"
echo # new line here =) 


select file in $sh_files; do
	# Check if the selection is valid
  if [ -n "$file" ]; then
	# Check if the script is running
    if pgrep -f "$file" > /dev/null; then
	  echo "The script $file is running."
	  exit 1
	else
	  # Run the selected .sh file in the background with nohup
      echo "" > "$file.log"
      nohup bash ./"$file" > "$file.log" 2>&1 & disown
      #&& rm "$file.log" &
      echo "Executing $file in the background. Check $file.log for output."
      exit 0
	fi
  else
    echo "Invalid selection. Please choose a number from the list."
    exit 1
  fi
done