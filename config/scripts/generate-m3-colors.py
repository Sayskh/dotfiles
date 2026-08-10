#!/usr/bin/env python3
"""
Extract dominant color from wallpaper and generate Material Design 3 color palette.
Saves output to ~/.cache/m3-colors.json for live QML loading.
"""

import sys
import json
import os
from PIL import Image

def get_dominant_color(image_path):
    try:
        img = Image.open(image_path)
        img = img.resize((50, 50))
        result = img.convert('P', palette=Image.ADAPTIVE, colors=1)
        result = result.convert('RGB')
        main_color = result.getcolors(50*50)[0][1]
        return main_color
    except Exception as e:
        return (203, 196, 203) # Fallback M3 primary

def hex_color(rgb):
    return f"#{rgb[0]:02x}{rgb[1]:02x}{rgb[2]:02x}"

def main():
    if len(sys.argv) < 2:
        sys.exit(0)
    
    wall_path = sys.argv[1]
    rgb = get_dominant_color(wall_path)
    primary = hex_color(rgb)

    m3_data = {
        "primary": primary,
        "wallpaper": wall_path
    }

    cache_dir = os.path.expanduser("~/.cache")
    os.makedirs(cache_dir, exist_ok=True)
    out_path = os.path.join(cache_dir, "m3-colors.json")

    with open(out_path, "w") as f:
        json.dump(m3_data, f, indent=2)

if __name__ == "__main__":
    main()
