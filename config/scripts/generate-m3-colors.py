#!/usr/bin/env python3
"""
Extract dominant color from wallpaper and generate Material Design 3 color palette.
Saves output to ~/.cache/m3-colors.json for live QML loading and updates MangoWC border colors.
"""

import sys
import json
import os
import re
from PIL import Image

def get_dominant_color(image_path):
    try:
        img = Image.open(image_path)
        img = img.resize((50, 50))
        result = img.convert('P', palette=Image.ADAPTIVE, colors=1)
        result = result.convert('RGB')
        main_color = result.getcolors(50*50)[0][1]
        return main_color
    except Exception:
        return (203, 196, 203) # Fallback M3 primary

def hex_color(rgb):
    return f"#{rgb[0]:02x}{rgb[1]:02x}{rgb[2]:02x}"

def mangowc_hex(rgb):
    return f"0xff{rgb[0]:02x}{rgb[1]:02x}{rgb[2]:02x}"

def update_mangowc_config(hex_color_val):
    config_path = os.path.expanduser("~/.config/mangowc/config")
    if not os.path.exists(config_path):
        return
    try:
        with open(config_path, "r") as f:
            content = f.read()
        
        # Replace active_border_color
        new_content = re.sub(
            r"active_border_color\s*=\s*0x[0-9a-fA-F]+",
            f"active_border_color = {hex_color_val}",
            content
        )
        with open(config_path, "w") as f:
            f.write(new_content)
    except Exception as e:
        print(f"Failed to update MangoWC config: {e}")

def main():
    if len(sys.argv) < 2:
        sys.exit(0)
    
    wall_path = sys.argv[1]
    rgb = get_dominant_color(wall_path)
    primary = hex_color(rgb)
    mango_hex = mangowc_hex(rgb)

    m3_data = {
        "primary": primary,
        "wallpaper": wall_path
    }

    cache_dir = os.path.expanduser("~/.cache")
    os.makedirs(cache_dir, exist_ok=True)
    out_path = os.path.join(cache_dir, "m3-colors.json")

    with open(out_path, "w") as f:
        json.dump(m3_data, f, indent=2)

    # Sync to MangoWC config
    update_mangowc_config(mango_hex)

if __name__ == "__main__":
    main()
