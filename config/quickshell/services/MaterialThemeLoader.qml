import QtQuick
import Quickshell
import Quickshell.Io
import "../modules/common"

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root

    property string colorsJsonPath: Directories.configPath + "/scripts/colors.json"

    FileView {
        id: fileView
        path: root.colorsJsonPath

        onLoaded: {
            try {
                let data = JSON.parse(fileView.text());
                if (data.special && data.colors) {
                    Appearance.m3colors.m3background = data.special.background || "#141313";
                    Appearance.m3colors.m3onBackground = data.special.foreground || "#e6e1e1";
                    Appearance.m3colors.m3surface = data.special.background || "#141313";
                    Appearance.m3colors.m3primary = data.colors.color1 || "#cbc4cb";
                    Appearance.m3colors.m3primaryContainer = data.colors.color2 || "#2d2a2f";
                    Appearance.m3colors.m3secondary = data.colors.color3 || "#cac5c8";
                    Appearance.m3colors.m3tertiary = data.colors.color4 || "#d3c2c8";
                }
            } catch (e) {
                console.log("[MaterialThemeLoader] Failed to parse colors.json: " + e);
            }
        }
    }

    function reloadTheme() {
        fileView.reload();
    }

    Component.onCompleted: {
        reloadTheme();
    }
}
