import QtQuick
import "../common"

MouseArea {
    implicitWidth: clockText.implicitWidth + 8
    implicitHeight: 28
    cursorShape: Qt.PointingHandCursor
    onClicked: GlobalStates.toggleSidebarLeft()

    Text {
        id: clockText
        anchors.centerIn: parent
        text: Qt.formatDateTime(new Date(), "HH:mm · ddd, MMM d")
        color: Appearance.m3colors.m3onSurface
        font.family: Appearance.font.family
        font.pixelSize: 13
        font.weight: Font.SemiBold

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clockText.text = Qt.formatDateTime(new Date(), "HH:mm · ddd, MMM d")
        }
    }
}
