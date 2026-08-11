import QtQuick
import QtQuick.Layouts
import "../common"
import "../common/widgets"

Rectangle {
    anchors.centerIn: parent
    width: 640
    height: 480
    radius: Appearance.rounding.extraLarge
    color: Appearance.m3colors.m3surface
    border.color: Appearance.m3colors.m3outlineVariant
    border.width: 1

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 16

        RowLayout {
            Layout.fillWidth: true

            Text {
                text: "Quick Settings & Config"
                color: Appearance.m3colors.m3onSurface
                font.family: Appearance.font.family
                font.pixelSize: 20
                font.weight: Font.Bold
            }

            Item { Layout.fillWidth: true }

            MouseArea {
                implicitWidth: 32
                implicitHeight: 32
                cursorShape: Qt.PointingHandCursor
                onClicked: GlobalStates.settingsOpen = false

                MaterialSymbol {
                    anchors.centerIn: parent
                    icon: "close"
                    size: 20
                    color: Appearance.m3colors.m3onSurfaceVariant
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: Appearance.m3colors.m3outlineVariant
        }

        Text {
            text: "Appearance & Shell Options"
            color: Appearance.m3colors.m3primary
            font.family: Appearance.font.family
            font.pixelSize: 14
            font.weight: Font.SemiBold
        }

        // Transparency Switch
        RowLayout {
            Layout.fillWidth: true
            Text {
                text: "Enable Panel Transparency"
                color: Appearance.m3colors.m3onSurface
                font.family: Appearance.font.family
                font.pixelSize: 13
                Layout.fillWidth: true
            }
            MouseArea {
                implicitWidth: 44
                implicitHeight: 24
                cursorShape: Qt.PointingHandCursor
                onClicked: Config.setNestedValue("appearance.transparency.enable", !Config.options.appearance.transparency.enable)
                Rectangle {
                    anchors.fill: parent
                    radius: 12
                    color: Config.options.appearance.transparency.enable ? Appearance.m3colors.m3primary : Appearance.m3colors.m3surfaceContainerHigh
                    Rectangle {
                        width: 18; height: 18; radius: 9
                        anchors.verticalCenter: parent.verticalCenter
                        x: Config.options.appearance.transparency.enable ? 22 : 4
                        color: Appearance.m3colors.m3onPrimary
                        Behavior on x { NumberAnimation { duration: Appearance.animation.fast } }
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
