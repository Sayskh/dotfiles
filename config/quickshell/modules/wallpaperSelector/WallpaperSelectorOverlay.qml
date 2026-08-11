import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../common"
import "../common/widgets"
import "../../services"

PanelWindow {
    id: wallpaperOverlay

    visible: GlobalStates.wallpaperSelectorOpen

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    color: Qt.rgba(0, 0, 0, 0.5)

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    MouseArea {
        anchors.fill: parent
        onClicked: GlobalStates.wallpaperSelectorOpen = false
    }

    MaterialShape {
        anchors.centerIn: parent
        width: 720
        height: 480
        radius: Appearance.rounding.extraLarge
        color: Appearance.m3colors.m3surfaceContainerHigh
        border.color: Qt.rgba(1, 1, 1, 0.08)
        border.width: 1

        MouseArea { anchors.fill: parent }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 16

            RowLayout {
                Layout.fillWidth: true

                MaterialSymbol {
                    icon: "wallpaper"
                    size: 24
                    color: Appearance.m3colors.m3primary
                }

                Text {
                    text: "Wallpaper Gallery & M3 Color Generator"
                    color: Appearance.m3colors.m3onSurface
                    font.family: Appearance.font.family
                    font.pixelSize: 18
                    font.weight: Font.Bold
                    Layout.fillWidth: true
                }

                MouseArea {
                    implicitWidth: 32
                    implicitHeight: 32
                    cursorShape: Qt.PointingHandCursor
                    onClicked: GlobalStates.wallpaperSelectorOpen = false

                    MaterialSymbol {
                        anchors.centerIn: parent
                        icon: "close"
                        size: 20
                        color: Appearance.m3colors.m3onSurfaceVariant
                    }
                }
            }

            // Randomize Button
            MouseArea {
                Layout.fillWidth: true
                implicitHeight: 48
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    WMInterface.runCmd("bash ~/.config/scripts/random-wallpaper.sh");
                    GlobalStates.wallpaperSelectorOpen = false;
                }

                MaterialShape {
                    anchors.fill: parent
                    radius: Appearance.rounding.medium
                    color: Appearance.m3colors.m3primaryContainer

                    RowLayout {
                        anchors.centerIn: parent
                        spacing: 8

                        MaterialSymbol {
                            icon: "shuffle"
                            size: 20
                            color: Appearance.m3colors.m3onPrimaryContainer
                        }

                        Text {
                            text: "Select Random Wallpaper & Regenerate M3 Theme"
                            color: Appearance.m3colors.m3onPrimaryContainer
                            font.family: Appearance.font.family
                            font.pixelSize: 13
                            font.weight: Font.Bold
                        }
                    }
                }
            }

            Item { Layout.fillHeight: true }
        }
    }
}
