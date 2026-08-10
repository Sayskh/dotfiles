import QtQuick
import QtQuick.Layouts
import "../"

Rectangle {
    id: root

    property color color: Appearance.m3colors.m3primaryContainer
    property color textColor: Appearance.m3colors.m3onPrimaryContainer
    property string text: ""
    property string icon: ""

    implicitHeight: 28
    implicitWidth: layout.implicitWidth + 24
    radius: Appearance.rounding.full
    color: root.color

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 6

        MaterialSymbol {
            visible: root.icon !== ""
            icon: root.icon
            size: 16
            color: root.textColor
        }

        Text {
            visible: root.text !== ""
            text: root.text
            color: root.textColor
            font.family: Appearance.font.family
            font.pixelSize: 12
            font.weight: Font.Medium
        }
    }

    Behavior on color {
        ColorAnimation { duration: Appearance.animation.normal }
    }
}
