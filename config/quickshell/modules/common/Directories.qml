import QtQuick
import Quickshell

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root

    readonly property string home: Quickshell.env("HOME") ?? "/home/hio"
    readonly property string config: home + "/.config"
    readonly property string quickshell: config + "/quickshell"
    readonly property string cache: home + "/.cache"
    readonly property string wallpapers: home + "/Pictures/Wallpapers"
    readonly property string defaultWallpaper: wallpapers + "/default.png"
}
