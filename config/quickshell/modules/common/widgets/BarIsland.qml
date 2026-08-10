import QtQuick
import QtQuick.Layouts
import "../"

Rectangle {
    id: root

    default property alias content: container.data
    property int spacing: 8

    implicitHeight: Appearance.sizes.barHeight - 8
    radius: Appearance.rounding.full
    color: Appearance.m3colors.m3surfaceContainer
    border.color: Qt.rgba(1, 1, 1, 0.05)
    border.width: 1

    RowLayout {
        id: container
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        spacing: root.spacing
    }

    Behavior on color {
        ColorAnimation { duration: Appearance.animation.normal }
    }
}
