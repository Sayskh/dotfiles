import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../common"
import "../common/widgets"
import "../common/models"

PanelWindow {
    id: leftSidebarWindow

    visible: GlobalStates.sidebarLeftOpen

    anchors {
        top: true
        bottom: true
        left: true
    }

    width: 380
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay

    MaterialShape {
        anchors.fill: parent
        anchors.margins: 12
        radius: Appearance.rounding.extraLarge
        color: Appearance.m3colors.m3surfaceContainerHigh
        border.color: Qt.rgba(1, 1, 1, 0.08)
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            // Header
            RowLayout {
                Layout.fillWidth: true

                MaterialSymbol {
                    icon: "calendar_today"
                    size: 22
                    color: Appearance.m3colors.m3primary
                }

                Text {
                    text: "Dashboard & Calendar"
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
                    onClicked: GlobalStates.sidebarLeftOpen = false

                    MaterialSymbol {
                        anchors.centerIn: parent
                        icon: "close"
                        size: 20
                        color: Appearance.m3colors.m3onSurfaceVariant
                    }
                }
            }

            // Big Clock Card
            MaterialShape {
                Layout.fillWidth: true
                implicitHeight: 100
                radius: Appearance.rounding.large
                color: Appearance.m3colors.m3primaryContainer

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 4

                    Text {
                        text: Qt.formatDateTime(new Date(), "hh:mm : ss")
                        color: Appearance.m3colors.m3onPrimaryContainer
                        font.family: Appearance.font.family
                        font.pixelSize: 32
                        font.weight: Font.Bold
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Text {
                        text: Qt.formatDateTime(new Date(), "dddd, MMMM d, yyyy")
                        color: Appearance.m3colors.m3onPrimaryContainer
                        font.family: Appearance.font.family
                        font.pixelSize: 13
                        font.weight: Font.Medium
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            // Quick Notes Card
            MaterialShape {
                Layout.fillWidth: true
                implicitHeight: 160
                radius: Appearance.rounding.large
                color: Appearance.m3colors.m3surfaceContainer

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 8

                    Text {
                        text: "Quick Notes"
                        color: Appearance.m3colors.m3primary
                        font.family: Appearance.font.family
                        font.pixelSize: 13
                        font.weight: Font.Bold
                    }

                    TextEdit {
                        id: noteInput
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: "• NixOS 25.11 Flake fully built\n• Audiophile PipeWire configured\n• Material Design 3 QML active"
                        color: Appearance.m3colors.m3onSurface
                        font.family: Appearance.font.family
                        font.pixelSize: 12
                        wrapMode: TextEdit.Wrap
                    }
                }
            }

            Item { Layout.fillHeight: true }
        }
    }
}
