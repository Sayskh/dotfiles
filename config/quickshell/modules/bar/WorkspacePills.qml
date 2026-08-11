import QtQuick
import QtQuick.Layouts
import "../common"
import "../common/models"

RowLayout {
    spacing: 4
    Repeater {
        model: 9
        delegate: MouseArea {
            required property int index
            implicitWidth: 26
            implicitHeight: 26
            cursorShape: Qt.PointingHandCursor
            onClicked: WMInterface.switchWorkspace(index + 1)

            Rectangle {
                anchors.centerIn: parent
                width: (index + 1) === WMInterface.activeWorkspace ? 22 : 8
                height: 8
                radius: 4
                color: (index + 1) === WMInterface.activeWorkspace
                    ? Appearance.m3colors.m3primary
                    : Appearance.m3colors.m3surfaceVariant

                Behavior on width {
                    NumberAnimation { duration: Appearance.animation.fast }
                }
                Behavior on color {
                    ColorAnimation { duration: Appearance.animation.fast }
                }
            }
        }
    }
}
