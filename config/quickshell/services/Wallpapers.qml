pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import "../modules/common"

Singleton {
    id: root

    property string wallpaperDir: Directories.wallpapers
    property string currentWallpaper: Config?.options.background.wallpaperPath ?? Directories.defaultWallpaper
    property list<string> wallpaperList: []
    property int currentIndex: 0

    Process {
        id: scanProc
        command: ["find", Directories.wallpapers, "-maxdepth", "2", "-type", "f", "(", "-name", "*.png", "-o", "-name", "*.jpg", "-o", "-name", "*.jpeg", "-o", "-name", "*.webp", ")"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const line = data.trim();
                if (line.length > 0 && !root.wallpaperList.includes(line)) {
                    root.wallpaperList.push(line);
                }
            }
        }
    }

    function setWallpaper(path: string, transition: string = "grow") {
        if (!path) return;
        root.currentWallpaper = path;
        Config.setNestedValue("background.wallpaperPath", path);
        Quickshell.execDetached(["swww", "img", path, "--transition-type", transition, "--transition-duration", "1"]);
        // Trigger color extraction
        Quickshell.execDetached(["python3", Directories.scriptPath + "/generate-m3-colors.py", path]);
    }

    function randomWallpaper() {
        if (root.wallpaperList.length === 0) return;
        const idx = Math.floor(Math.random() * root.wallpaperList.length);
        root.currentIndex = idx;
        setWallpaper(root.wallpaperList[idx], "outer");
    }

    function nextWallpaper() {
        if (root.wallpaperList.length === 0) return;
        root.currentIndex = (root.currentIndex + 1) % root.wallpaperList.length;
        setWallpaper(root.wallpaperList[root.currentIndex], "wave");
    }

    function previousWallpaper() {
        if (root.wallpaperList.length === 0) return;
        root.currentIndex = (root.currentIndex - 1 + root.wallpaperList.length) % root.wallpaperList.length;
        setWallpaper(root.wallpaperList[root.currentIndex], "wave");
    }

    Component.onCompleted: {
        scanProc.running = true;
    }
}
