import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../common"
import "../common/widgets"
import "../common/models"

PanelWindow {
    id: lockWindow

    visible: GlobalStates.screenLocked

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    color: Qt.rgba(0.08, 0.08, 0.08, 0.95)

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 24

        // Clock
        Text {
            text: Qt.formatDateTime(new Date(), "HH:mm")
            color: Appearance.m3colors.m3onSurface
            font.family: Appearance.font.family
            font.pixelSize: 72
            font.weight: Font.Bold
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: Qt.formatDateTime(new Date(), "dddd, MMMM d")
            color: Appearance.m3colors.m3onSurfaceVariant
            font.family: Appearance.font.family
            font.pixelSize: 18
            Layout.alignment: Qt.AlignHCenter
        }

        // Password Input Box
        MaterialShape {
            implicitWidth: 320
            implicitHeight: 52
            radius: Appearance.rounding.full
            color: Appearance.m3colors.m3surfaceContainerHigh

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                spacing: 12

                MaterialSymbol {
                    icon: "lock"
                    size: 20
                    color: Appearance.m3colors.m3primary
                }

                TextInput {
                    id: pwdInput
                    Layout.fillWidth: true
                    font.family: Appearance.font.family
                    font.pixelSize: 14
                    echoMode: TextInput.Password
                    color: Appearance.m3colors.m3onSurface
                    focus: lockWindow.visible

                    Text {
                        text: "Enter Password to Unlock..."
                        color: Appearance.m3colors.m3onSurfaceVariant
                        font: pwdInput.font
                        visible: !pwdInput.text
                    }

                    onAccepted: {
                        pwdInput.text = "";
                        GlobalStates.screenLocked = false;
                    }
                }
            }
        }
    }
}
