pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick

Singleton {
    id: root

    property string defaultAvatar: Directories.assetsPath + "/avatar.png"
    property string defaultCoverArt: Directories.assetsPath + "/default_cover.png"
    property string fallbackWallpaper: Directories.defaultWallpaper
}
