import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../common"
import "../common/widgets"

PanelWindow {
    id: notifWindow

    // Visible when a notification arrives
    visible: false

    anchors {
        top: true
        right: true
    }

    height: 90
    width: 340
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay

    MaterialShape {
        anchors.fill: parent
        anchors.margins: 8
        radius: Appearance.rounding.large
        color: Appearance.m3colors.m3surfaceContainerHigh
        border.color: Qt.rgba(1, 1, 1, 0.08)
        border.width: 1

        RowLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 12

            MaterialShape {
                implicitWidth: 40
                implicitHeight: 40
                radius: Appearance.rounding.full
                color: Appearance.m3colors.m3primaryContainer

                MaterialSymbol {
                    anchors.centerIn: parent
                    icon: "notifications"
                    size: 20
                    color: Appearance.m3colors.m3onPrimaryContainer
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 2

                Text {
                    text: "System Notification"
                    color: Appearance.m3colors.m3onSurface
                    font.family: Appearance.font.family
                    font.pixelSize: 13
                    font.weight: Font.Bold
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }

                Text {
                    text: "Everything is running smoothly on nixbtw."
                    color: Appearance.m3colors.m3onSurfaceVariant
                    font.family: Appearance.font.family
                    font.pixelSize: 12
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }
            }
        }
    }
}
