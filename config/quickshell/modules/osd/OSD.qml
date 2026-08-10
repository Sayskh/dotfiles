import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../common"
import "../common/widgets"

PanelWindow {
    id: osdWindow

    visible: GlobalStates.osdVolumeOpen || GlobalStates.osdBrightnessOpen

    anchors {
        bottom: true
        horizontalCenter: true
    }

    height: 60
    width: 280
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay

    MaterialShape {
        anchors.fill: parent
        anchors.margins: 4
        radius: Appearance.rounding.full
        color: Appearance.m3colors.m3surfaceContainerHigh
        border.color: Qt.rgba(1, 1, 1, 0.08)
        border.width: 1

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            spacing: 12

            MaterialSymbol {
                icon: GlobalStates.osdVolumeOpen ? "volume_up" : "brightness_6"
                size: 22
                color: Appearance.m3colors.m3primary
            }

            Rectangle {
                Layout.fillWidth: true
                height: 8
                radius: 4
                color: Appearance.m3colors.m3surfaceVariant

                Rectangle {
                    width: parent.width * 0.65
                    height: parent.height
                    radius: parent.radius
                    color: Appearance.m3colors.m3primary
                }
            }

            Text {
                text: "65%"
                color: Appearance.m3colors.m3onSurface
                font.family: Appearance.font.family
                font.pixelSize: 13
                font.weight: Font.Bold
            }
        }
    }
}
