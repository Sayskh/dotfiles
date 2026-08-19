import QtQuick
import Quickshell
import Quickshell.Wayland
import "../common"

PanelWindow {
    id: barWindow

    readonly property bool isBottom: (Config.options.bar?.position ?? "Top") === "Bottom"

    anchors {
        top: !barWindow.isBottom
        bottom: barWindow.isBottom
        left: true
        right: true
    }

    height: Appearance.sizes.barHeight + 8
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.exclusiveZone: barWindow.height

    BarContent {}
}
