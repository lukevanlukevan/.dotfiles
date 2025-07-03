#!/bin/bash

HIDDEN_LABEL="hidden"
CACHE_FILE="/tmp/yabai-hidden-window.json"

# Check for required dependencies
command -v jq >/dev/null 2>&1 || {
  echo >&2 "jq is required but not installed."
  exit 1
}

# Get focused window ID and space index
win_id=$(yabai -m query --windows --window | jq -r '.id')
current_space=$(yabai -m query --windows --window | jq -r '.space')

# Check if hidden cache exists
if [[ -f "$CACHE_FILE" ]]; then
  cached_id=$(jq -r '.id' <"$CACHE_FILE")
  original_space=$(jq -r '.space' <"$CACHE_FILE")

  if [[ "$win_id" == "$cached_id" ]]; then
    # Bring back to original space
    yabai -m window "$win_id" --space "$original_space"
    yabai -m space --focus "$original_space"
    rm "$CACHE_FILE"
    exit 0
  fi
fi

# Find or create a space labeled "hidden"
hidden_space_id=$(yabai -m query --spaces | jq -r ".[] | select(.label == \"$HIDDEN_LABEL\") | .index")

if [[ -z "$hidden_space_id" ]]; then
  # Get last display index
  last_display=$(yabai -m query --displays | jq '.[-1].index')

  # Create new space on last display
  yabai -m space --create "$last_display"
  sleep 0.2 # small delay to let space register

  # Get the new space index
  new_space=$(yabai -m query --spaces | jq '.[-1].index')

  # Label it as hidden
  yabai -m space "$new_space" --label "$HIDDEN_LABEL"
  hidden_space_id="$new_space"
fi

# Cache original space and hide window
echo "{\"id\": \"$win_id\", \"space\": \"$current_space\"}" >"$CACHE_FILE"
yabai -m window "$win_id" --space "$hidden_space_id"
