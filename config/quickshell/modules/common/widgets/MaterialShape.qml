import QtQuick
import QtQuick.Layouts
import "../"

Rectangle {
    id: root

    property color color: Appearance.m3colors.m3surfaceContainer
    property color borderColor: Appearance.m3colors.m3outlineVariant
    property int borderWidth: 0
    property int radius: Appearance.rounding.medium

    color: root.color
    border.color: root.borderColor
    border.width: root.borderWidth
    radius: root.radius

    Behavior on color {
        ColorAnimation { duration: Appearance.animation.normal }
    }
    Behavior on border.color {
        ColorAnimation { duration: Appearance.animation.normal }
    }
}
