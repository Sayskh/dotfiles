import QtQuick
import Quickshell
import Quickshell.Wayland
import "../common"

PanelWindow {
    id: barWindow

    anchors {
        top: true
        left: true
        right: true
    }

    height: Appearance.sizes.barHeight + 8
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.exclusiveZone: barWindow.height

    BarContent {}
}
