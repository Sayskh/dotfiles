#!/usr/bin/env bash
# Random Wallpaper selector + pywal + M3 recoloring script

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Create directory if it doesn't exist
mkdir -p "$WALLPAPER_DIR"

# Pick random wallpaper
if [ -d "$WALLPAPER_DIR" ] && [ "$(ls -A "$WALLPAPER_DIR")" ]; then
    WALL=$(find "$WALLPAPER_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | shuf -n 1)
else
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

echo "Setting wallpaper: $WALL"

# Apply via swww (smooth transition)
swww img "$WALL" --transition-type grow --transition-duration 1.2 --transition-fps 60

# Generate pywal colorscheme
wal -i "$WALL" -n -q

# Generate M3 colors JSON if Python script exists
if [ -f "$HOME/.config/scripts/generate-m3-colors.py" ]; then
    python3 "$HOME/.config/scripts/generate-m3-colors.py" "$WALL"
fi
