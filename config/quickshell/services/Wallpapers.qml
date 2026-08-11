import QtQuick
import Quickshell
import Quickshell.Io

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root

    property string wallpaperDir: Directories.homePath + "/Pictures/Wallpapers"
    property string currentWallpaper: wallpaperDir + "/default.png"

    Process {
        id: changeProc
    }

    function setWallpaper(path: string) {
        root.currentWallpaper = path;
        changeProc.exec(["swww", "img", path, "--transition-type", "grow", "--transition-duration", "1"]);
        // Extract colors via script
        changeProc.exec(["bash", Directories.configPath + "/scripts/random-wallpaper.sh"]);
    }
}
