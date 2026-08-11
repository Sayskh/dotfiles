pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import QtCore
import "./functions"

Singleton {
    id: root

    // XDG Dirs with "file://"
    readonly property string home: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0] ?? "file:///home/user"
    readonly property string config: StandardPaths.standardLocations(StandardPaths.ConfigLocation)[0] ?? (home + "/.config")
    readonly property string state: StandardPaths.standardLocations(StandardPaths.StateLocation)[0] ?? (home + "/.local/state")
    readonly property string cache: StandardPaths.standardLocations(StandardPaths.CacheLocation)[0] ?? (home + "/.cache")
    readonly property string genericCache: StandardPaths.standardLocations(StandardPaths.GenericCacheLocation)[0] ?? (home + "/.cache")
    readonly property string documents: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0] ?? (home + "/Documents")
    readonly property string downloads: StandardPaths.standardLocations(StandardPaths.DownloadLocation)[0] ?? (home + "/Downloads")
    readonly property string pictures: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0] ?? (home + "/Pictures")
    readonly property string music: StandardPaths.standardLocations(StandardPaths.MusicLocation)[0] ?? (home + "/Music")
    readonly property string videos: StandardPaths.standardLocations(StandardPaths.MoviesLocation)[0] ?? (home + "/Videos")

    // Other dirs used by the shell, without "file://"
    property string assetsPath: Quickshell.shellPath("assets")
    property string scriptPath: Quickshell.shellPath("scripts")
    property string favicons: FileUtils.trimFileProtocol(cache + "/media/favicons")
    property string coverArt: FileUtils.trimFileProtocol(cache + "/media/coverart")
    property string tempImages: "/tmp/quickshell/media/images"
    property string shellConfig: FileUtils.trimFileProtocol(config + "/dotfiles")
    property string shellConfigName: "config.json"
    property string shellConfigPath: shellConfig + "/" + shellConfigName
    property string todoPath: FileUtils.trimFileProtocol(state + "/user/todo.json")
    property string notesPath: FileUtils.trimFileProtocol(state + "/user/notes.txt")
    property string desktopNotesPath: FileUtils.trimFileProtocol(state + "/user/desktopnotes.txt")
    property string persistentStatePath: FileUtils.trimFileProtocol(state + "/user/persistent.json")
    property string notificationsPath: FileUtils.trimFileProtocol(cache + "/notifications/notifications.json")
    property string generatedMaterialThemePath: FileUtils.trimFileProtocol(state + "/user/generated/colors.json")
    property string generatedWallpaperCategoryPath: FileUtils.trimFileProtocol(state + "/user/generated/wallpaper/category.txt")
    property string cliphistDecode: "/tmp/quickshell/media/cliphist"
    property string screenshotTemp: "/tmp/quickshell/media/screenshot"
    property string wallpapers: FileUtils.trimFileProtocol(pictures + "/Wallpapers")
    property string defaultWallpaper: wallpapers + "/default.png"

    Component.onCompleted: {
        Quickshell.execDetached(["mkdir", "-p", shellConfig])
        Quickshell.execDetached(["mkdir", "-p", FileUtils.trimFileProtocol(state + "/user")])
        Quickshell.execDetached(["mkdir", "-p", FileUtils.trimFileProtocol(cache + "/notifications")])
        Quickshell.execDetached(["mkdir", "-p", favicons])
        Quickshell.execDetached(["mkdir", "-p", coverArt])
    }
}
