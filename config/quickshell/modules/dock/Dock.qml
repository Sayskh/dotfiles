import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../common"
import "../common/widgets"
import "../common/models"

PanelWindow {
    id: dockWindow

    anchors {
        bottom: true
        horizontalCenter: true
    }

    height: Appearance.sizes.dockHeight + 16
    width: dockLayout.implicitWidth + 32
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Top

    Rectangle {
        anchors.fill: parent
        anchors.margins: 8
        radius: Appearance.rounding.full
        color: Appearance.m3colors.m3surfaceContainerHigh
        border.color: Qt.rgba(1, 1, 1, 0.08)
        border.width: 1

        RowLayout {
            id: dockLayout
            anchors.centerIn: parent
            spacing: 12

            // App Item Component
            component DockIcon : MouseArea {
                id: item
                required property string iconName
                required property string execName
                property bool isHovered: false

                implicitWidth: 44
                implicitHeight: 44
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onEntered: isHovered = true
                onExited: isHovered = false
                onClicked: WMInterface.launchApp(execName)

                Rectangle {
                    anchors.centerIn: parent
                    width: item.isHovered ? 44 : 40
                    height: width
                    radius: Appearance.rounding.medium
                    color: item.isHovered ? Appearance.m3colors.m3surfaceBright : Appearance.m3colors.m3surfaceContainer

                    MaterialSymbol {
                        anchors.centerIn: parent
                        icon: item.iconName
                        size: item.isHovered ? 24 : 20
                        color: Appearance.m3colors.m3primary
                    }

                    Behavior on width {
                        NumberAnimation { duration: Appearance.animation.fast }
                    }
                    Behavior on color {
                        ColorAnimation { duration: Appearance.animation.fast }
                    }
                }
            }

            DockIcon { iconName: "web"; execName: "zen-browser" }
            DockIcon { iconName: "terminal"; execName: "kitty" }
            DockIcon { iconName: "folder"; execName: "thunar" }
            DockIcon { iconName: "chat"; execName: "vesktop" }
            DockIcon { iconName: "music_note"; execName: "spotify" }
        }
    }
}
