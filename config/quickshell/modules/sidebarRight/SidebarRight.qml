import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../common"
import "../common/widgets"
import "../common/models"

PanelWindow {
    id: sidebarWindow

    visible: GlobalStates.sidebarRightOpen

    anchors {
        top: true
        bottom: true
        right: true
    }

    width: 360
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

                Text {
                    text: "Control Center"
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
                    onClicked: GlobalStates.sidebarRightOpen = false

                    MaterialSymbol {
                        anchors.centerIn: parent
                        icon: "close"
                        size: 20
                        color: Appearance.m3colors.m3onSurfaceVariant
                    }
                }
            }

            // Quick Toggle Grid (2x3)
            GridLayout {
                columns: 2
                columnSpacing: 12
                rowSpacing: 12
                Layout.fillWidth: true

                component QuickToggleTile : MouseArea {
                    id: tile
                    required property string label
                    required property string iconName
                    property bool active: true

                    implicitWidth: 150
                    implicitHeight: 64
                    cursorShape: Qt.PointingHandCursor
                    onClicked: tile.active = !tile.active

                    MaterialShape {
                        anchors.fill: parent
                        radius: Appearance.rounding.medium
                        color: tile.active ? Appearance.m3colors.m3primaryContainer : Appearance.m3colors.m3surfaceContainer

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 12
                            anchors.rightMargin: 12
                            spacing: 10

                            MaterialSymbol {
                                icon: tile.iconName
                                size: 22
                                color: tile.active ? Appearance.m3colors.m3onPrimaryContainer : Appearance.m3colors.m3onSurfaceVariant
                            }

                            Text {
                                text: tile.label
                                color: tile.active ? Appearance.m3colors.m3onPrimaryContainer : Appearance.m3colors.m3onSurface
                                font.family: Appearance.font.family
                                font.pixelSize: 12
                                font.weight: Font.Medium
                                elide: Text.ElideRight
                                Layout.fillWidth: true
                            }
                        }
                    }
                }

                QuickToggleTile { label: "Dark Mode"; iconName: "dark_mode"; active: true }
                QuickToggleTile { label: "Wi-Fi"; iconName: "wifi"; active: true }
                QuickToggleTile { label: "Bluetooth"; iconName: "bluetooth"; active: true }
                QuickToggleTile { label: "Audio Mute"; iconName: "volume_up"; active: false }
                QuickToggleTile { label: "Night Light"; iconName: "nightlight"; active: false }
                QuickToggleTile { label: "Do Not Disturb"; iconName: "notifications_off"; active: false }
            }

            // Power Session Buttons Footer
            RowLayout {
                Layout.fillWidth: true
                spacing: 12

                component PowerBtn : MouseArea {
                    id: pBtn
                    required property string iconName
                    required property string cmd

                    implicitWidth: 44
                    implicitHeight: 44
                    cursorShape: Qt.PointingHandCursor
                    onClicked: WMInterface.runCmd(cmd)

                    MaterialShape {
                        anchors.fill: parent
                        radius: Appearance.rounding.full
                        color: Appearance.m3colors.m3surfaceContainer

                        MaterialSymbol {
                            anchors.centerIn: parent
                            icon: pBtn.iconName
                            size: 20
                            color: Appearance.m3colors.m3primary
                        }
                    }
                }

                Item { Layout.fillWidth: true }
                PowerBtn { iconName: "lock"; cmd: "loginctl lock-session" }
                PowerBtn { iconName: "restart_alt"; cmd: "systemctl reboot" }
                PowerBtn { iconName: "power_settings_new"; cmd: "systemctl poweroff" }
            }

            Item { Layout.fillHeight: true }
        }
    }
}
