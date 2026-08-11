pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io
import "./functions"

Singleton {
    id: root
    property string filePath: Directories.shellConfigPath
    property alias options: configOptionsJsonAdapter
    property bool ready: false
    property int readWriteDelay: 50
    property bool blockWrites: false

    function setNestedValue(nestedKey: string, value: var) {
        let keys = nestedKey.split(".");
        let obj = root.options;
        for (let i = 0; i < keys.length - 1; ++i) {
            if (!obj[keys[i]] || typeof obj[keys[i]] !== "object") {
                obj[keys[i]] = {};
            }
            obj = obj[keys[i]];
        }
        let convertedValue = value;
        if (typeof value === "string") {
            let trimmed = value.trim();
            if (trimmed === "true" || trimmed === "false" || !isNaN(Number(trimmed))) {
                try {
                    convertedValue = JSON.parse(trimmed);
                } catch (e) {
                    convertedValue = value;
                }
            }
        }
        obj[keys[keys.length - 1]] = convertedValue;
    }

    Timer {
        id: fileReloadTimer
        interval: root.readWriteDelay
        repeat: false
        onTriggered: configFileView.reload()
    }

    Timer {
        id: fileWriteTimer
        interval: root.readWriteDelay
        repeat: false
        onTriggered: configFileView.writeAdapter()
    }

    FileView {
        id: configFileView
        path: root.filePath
        watchChanges: true
        blockWrites: root.blockWrites
        onFileChanged: fileReloadTimer.restart()
        onAdapterUpdated: fileWriteTimer.restart()
        onLoaded: root.ready = true
        onLoadFailed: error => {
            if (error === FileViewError.FileNotFound) {
                writeAdapter();
            }
        }

        JsonAdapter {
            id: configOptionsJsonAdapter

            property string panelFamily: "ii"

            property QtObject appearance: QtObject {
                property QtObject transparency: QtObject {
                    property bool enable: true
                    property bool automatic: true
                    property real backgroundTransparency: 0.15
                    property real contentTransparency: 0.90
                }
                property QtObject rounding: QtObject {
                    property int scale: 1
                }
                property QtObject animations: QtObject {
                    property bool enable: true
                    property int speed: 250
                }
            }

            property QtObject bar: QtObject {
                property bool enable: true
                property int height: 44
                property string position: "top"
                property bool floating: true
                property QtObject modules: QtObject {
                    property bool launcher: true
                    property bool workspaces: true
                    property bool windowTitle: true
                    property bool clock: true
                    property bool systray: true
                    property bool quicksettings: true
                }
            }

            property QtObject dock: QtObject {
                property bool enable: true
                property int height: 64
                property bool autohide: false
                property bool floating: true
                property int iconSize: 48
            }

            property QtObject notifications: QtObject {
                property bool enable: true
                property int timeout: 7000
                property bool groupByApp: true
                property bool sound: true
                property string position: "top-right"
            }

            property QtObject audio: QtObject {
                property string theme: "freedesktop"
                property QtObject protection: QtObject {
                    property bool enable: true
                    property int maxAllowedIncrease: 20
                    property int maxAllowed: 100
                }
            }

            property QtObject background: QtObject {
                property string wallpaperPath: Directories.defaultWallpaper
                property string lockWall: ""
                property bool blur: true
                property int blurRadius: 30
            }

            property QtObject overview: QtObject {
                property bool enable: true
                property int columns: 3
            }

            property QtObject osd: QtObject {
                property bool enable: true
                property int timeout: 2000
            }

            property QtObject search: QtObject {
                property bool enable: true
                property string defaultEngine: "google"
            }
        }
    }
}
