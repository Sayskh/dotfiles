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

    // Desktop Left Side Widgets (Profile, Petal Clock, Weather)
    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 60
        anchors.leftMargin: 40
        spacing: 24
        visible: Config?.options.desktopWidgets?.enable ?? true

        ProfileWidget {
            Layout.alignment: Qt.AlignHCenter
        }

        ClockWidget {
            Layout.alignment: Qt.AlignHCenter
        }

        WeatherWidget {
            Layout.alignment: Qt.AlignHCenter
        }
    }

    // Desktop Right Side Widgets (Media, Calendar)
    ColumnLayout {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 40
        spacing: 20
        visible: Config?.options.desktopWidgets?.enable ?? true

        MediaWidget {
            visible: MprisController.isPlaying || MprisController.title !== "No Media Playing"
        }

        CalendarWidget {}
    }
}
