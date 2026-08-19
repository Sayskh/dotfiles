import QtQuick
import "../../common"

Rectangle {
    id: root
    width: 140
    height: 140
    radius: 70
    color: Appearance.colors.surfaceContainerHigh
    border.color: Appearance.colors.outlineVariant
    border.width: 2
    clip: true

    Image {
        id: avatarImg
        anchors.fill: parent
        source: Images.defaultAvatar
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }

    Rectangle {
        anchors.fill: parent
        radius: parent.radius
        color: "transparent"
        border.color: Appearance.colors.primary
        border.width: 2
        opacity: 0.7
    }
}
