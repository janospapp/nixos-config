#!/usr/bin/env bash

# Check if Firefox is the active window (YouTube/Jellyfin tab)
WINCLASS=$(hyprctl activewindow -j | jq -r '.class' 2>/dev/null)

if [[ "$WINCLASS" == "teams-for-linux" ]]; then
  exit 0   # inhibit lock when Teams is active (in a video call probably)
fi

if [[ "$WINCLASS" != "firefox" ]]; then
  exit 1   # Not Firefox → allow locking
fi

# Is there ANY active playing media via playerctl?
STATUS=$(playerctl status 2>/dev/null || echo "None")

if [[ "$STATUS" == "Playing" ]]; then
  exit 0   # Video is playing → inhibit lock
fi

exit 1       # No playback → allow lock
