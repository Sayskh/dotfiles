import QtQuick
import QtQuick.Layouts
import "../common"
import "../common/widgets"

MouseArea {
    id: root
    property string iconName: "power_settings_new"
    property string labelText: "Power"
    property color iconColor: Appearance.m3colors.m3primary
    signal actionTriggered()

    implicitWidth: 100
    implicitHeight: 100
    cursorShape: Qt.PointingHandCursor
    onClicked: root.actionTriggered()

    Rectangle {
        anchors.fill: parent
        radius: Appearance.rounding.large
        color: root.containsMouse ? Appearance.m3colors.m3surfaceContainerHigh : Appearance.m3colors.m3surfaceContainer

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 8

            MaterialSymbol {
                Layout.alignment: Qt.AlignHCenter
                icon: root.iconName
                size: 32
                color: root.iconColor
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: root.labelText
                color: Appearance.m3colors.m3onSurface
                font.family: Appearance.font.family
                font.pixelSize: 13
                font.weight: Font.Medium
            }
        }

        Behavior on color { ColorAnimation { duration: Appearance.animation.fast } }
    }
}
