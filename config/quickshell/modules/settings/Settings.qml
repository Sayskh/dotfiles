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

    visible: GlobalStates.settingsOpen
    color: Qt.rgba(0, 0, 0, 0.5)

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    MouseArea {
        anchors.fill: parent
        onClicked: GlobalStates.settingsOpen = false
    }

    SettingsContent {}
}
