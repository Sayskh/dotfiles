import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../common"
import "../../services"
import "./widgets"

PanelWindow {
    id: root

    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    color: "transparent"

    // Background Wallpaper Image
    Image {
        id: bgImage
        anchors.fill: parent
        source: Wallpapers.currentWallpaper
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        smooth: true
    }

    // Subtle dark tint
    Rectangle {
        anchors.fill: parent
        color: "#18000000"
    }

    // Desktop Widgets Area (Top Right)
    ColumnLayout {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 40
        spacing: 20
        visible: Config?.options.desktopWidgets?.enable ?? true

        MediaWidget {
            id: mediaWidget
            visible: MprisController.isPlaying || MprisController.title !== "No Media Playing"
        }

        CalendarWidget {
            id: calendarWidget
        }
    }
}
