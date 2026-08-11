import QtQuick
import Quickshell
import Quickshell.Wayland
import "../common"
import "../"

PanelWindow {
    id: root

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    visible: GlobalStates.sessionOpen
    color: Qt.rgba(0, 0, 0, 0.6)

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    MouseArea {
        anchors.fill: parent
        onClicked: GlobalStates.sessionOpen = false
    }

    SessionContent {}
}
