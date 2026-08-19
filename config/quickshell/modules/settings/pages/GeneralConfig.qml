import QtQuick
import QtQuick.Layouts
import "../../common"
import "../../common/widgets"
import "../../../services"

ColumnLayout {
    spacing: 20
    width: parent?.width ?? 400

    Text {
        text: "General Configuration"
        font.family: Appearance.font.family
        font.pixelSize: 18
        font.weight: Font.Bold
        color: Appearance.colors.onSurface
    }

    // Transparency
    RowLayout {
        Layout.fillWidth: true
        Text {
            text: "Window & Panel Transparency"
            font.family: Appearance.font.family
            font.pixelSize: 13
            color: Appearance.colors.onSurface
            Layout.fillWidth: true
        }

        MouseArea {
            implicitWidth: 44
            implicitHeight: 24
            cursorShape: Qt.PointingHandCursor
            onClicked: Config.setNestedValue("appearance.transparency.enable", !(Config.options.appearance?.transparency?.enable ?? true))
            Rectangle {
                anchors.fill: parent
                radius: 12
                color: (Config.options.appearance?.transparency?.enable ?? true) ? Appearance.colors.primary : Appearance.colors.surfaceContainerHighest
                Rectangle {
                    width: 18; height: 18; radius: 9
                    anchors.verticalCenter: parent.verticalCenter
                    x: (Config.options.appearance?.transparency?.enable ?? true) ? 22 : 4
                    color: Appearance.colors.onPrimary
                    Behavior on x { NumberAnimation { duration: Appearance.animation.fast } }
                }
            }
        }
    }

    // Dynamic Theming
    RowLayout {
        Layout.fillWidth: true
        Text {
            text: "Auto Material 3 Wallpaper Theming"
            font.family: Appearance.font.family
            font.pixelSize: 13
            color: Appearance.colors.onSurface
            Layout.fillWidth: true
        }

        MouseArea {
            implicitWidth: 44
            implicitHeight: 24
            cursorShape: Qt.PointingHandCursor
            onClicked: Config.setNestedValue("appearance.dynamicTheming.enable", !(Config.options.appearance?.dynamicTheming?.enable ?? true))
            Rectangle {
                anchors.fill: parent
                radius: 12
                color: (Config.options.appearance?.dynamicTheming?.enable ?? true) ? Appearance.colors.primary : Appearance.colors.surfaceContainerHighest
                Rectangle {
                    width: 18; height: 18; radius: 9
                    anchors.verticalCenter: parent.verticalCenter
                    x: (Config.options.appearance?.dynamicTheming?.enable ?? true) ? 22 : 4
                    color: Appearance.colors.onPrimary
                    Behavior on x { NumberAnimation { duration: Appearance.animation.fast } }
                }
            }
        }
    }
}
