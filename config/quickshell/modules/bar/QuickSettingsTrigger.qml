import QtQuick
import "../common"
import "../common/widgets"

MouseArea {
    implicitWidth: 28
    implicitHeight: 28
    cursorShape: Qt.PointingHandCursor
    onClicked: GlobalStates.toggleSidebarRight()

    MaterialSymbol {
        anchors.centerIn: parent
        icon: "tune"
        size: 18
        color: Appearance.m3colors.m3onSurfaceVariant
    }
}
