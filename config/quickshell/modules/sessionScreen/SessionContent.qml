import QtQuick
import QtQuick.Layouts
import Quickshell
import "../common"
import "../"

Rectangle {
    anchors.centerIn: parent
    width: 480
    height: 220
    radius: Appearance.rounding.extraLarge
    color: Appearance.m3colors.m3surface
    border.color: Appearance.m3colors.m3outlineVariant
    border.width: 1

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 20

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Session Options"
            color: Appearance.m3colors.m3onSurface
            font.family: Appearance.font.family
            font.pixelSize: 20
            font.weight: Font.Bold
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 16

            SessionButton {
                iconName: "lock"
                labelText: "Lock"
                onActionTriggered: {
                    GlobalStates.sessionOpen = false;
                    GlobalStates.screenLocked = true;
                }
            }

            SessionButton {
                iconName: "logout"
                labelText: "Logout"
                onActionTriggered: {
                    Quickshell.execDetached(["hyprctl", "dispatch", "exit"]);
                    Quickshell.execDetached(["loginctl", "terminate-user", ""]);
                }
            }

            SessionButton {
                iconName: "restart_alt"
                labelText: "Reboot"
                onActionTriggered: Quickshell.execDetached(["systemctl", "reboot"])
            }

            SessionButton {
                iconName: "power_settings_new"
                labelText: "Shutdown"
                iconColor: Appearance.m3colors.m3error
                onActionTriggered: Quickshell.execDetached(["systemctl", "poweroff"])
            }
        }
    }
}
