import QtQuick
import "../"

Text {
    id: root

    property string icon: ""
    property int size: Appearance.sizes.iconSize
    property color color: Appearance.m3colors.m3onSurface

    font.family: Appearance.font.symbols
    font.pixelSize: root.size
    text: root.icon
    color: root.color
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    Behavior on color {
        ColorAnimation { duration: Appearance.animation.normal }
    }
}
