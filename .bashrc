#!/bin/bash

# Define session names and associated commands
declare -A sessions=(
  ["gomo"]="z good && yarn dev"
  ["gmt"]="z gm && uv run main.py"
  ["spanish"]="z spanish && uv run main.py"
)

for session in "${!sessions[@]}"; do
  cmd="${sessions[$session]}"
  echo "Creating tmux session: $session"

  # Start new tmux session in detached mode and run the command
  tmux new-session -d -s "$session" "$cmd"

  if [ $? -eq 0 ]; then
    echo "Session '$session' started and detached."
  else
    echo "Failed to start session '$session'."
  fi
done

echo "All tmux sessions started."
