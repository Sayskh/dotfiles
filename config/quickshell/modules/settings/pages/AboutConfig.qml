import QtQuick
import QtQuick.Layouts
import "../../common"
import "../../common/widgets"
import "../../../services"

ColumnLayout {
    spacing: 16
    width: parent?.width ?? 400

    RowLayout {
        spacing: 16
        Rectangle {
            width: 56
            height: 56
            radius: 28
            color: Appearance.colors.primaryContainer

            MaterialSymbol {
                anchors.centerIn: parent
                icon: "info"
                iconSize: 28
                color: Appearance.colors.onPrimaryContainer
            }
        }

        ColumnLayout {
            spacing: 2
            Text {
                text: "NixOS MangoWC"
                font.family: Appearance.font.family
                font.pixelSize: 18
                font.weight: Font.Bold
                color: Appearance.colors.onSurface
            }
            Text {
                text: "Material Design 3 Shell • Quickshell"
                font.family: Appearance.font.family
                font.pixelSize: 13
                color: Appearance.colors.onSurfaceVariant
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
        height: 1
        color: Appearance.colors.outlineVariant
    }

    Text {
        text: "System Information"
        font.family: Appearance.font.family
        font.pixelSize: 14
        font.weight: Font.Bold
        color: Appearance.colors.primary
    }

    RowLayout {
        Text {
            text: "Kernel:"
            font.family: Appearance.font.family
            font.pixelSize: 12
            color: Appearance.colors.onSurfaceVariant
            Layout.preferredWidth: 100
        }
        Text {
            text: SystemInfo.kernelVersion || "Linux CachyOS BORE"
            font.family: Appearance.font.family
            font.pixelSize: 12
            font.weight: Font.Medium
            color: Appearance.colors.onSurface
        }
    }

    RowLayout {
        Text {
            text: "Compositor:"
            font.family: Appearance.font.family
            font.pixelSize: 12
            color: Appearance.colors.onSurfaceVariant
            Layout.preferredWidth: 100
        }
        Text {
            text: "MangoWC (scenefx + mmsg IPC)"
            font.family: Appearance.font.family
            font.pixelSize: 12
            font.weight: Font.Medium
            color: Appearance.colors.onSurface
        }
    }

    RowLayout {
        Text {
            text: "Shell Engine:"
            font.family: Appearance.font.family
            font.pixelSize: 12
            color: Appearance.colors.onSurfaceVariant
            Layout.preferredWidth: 100
        }
        Text {
            text: "Quickshell QML"
            font.family: Appearance.font.family
            font.pixelSize: 12
            font.weight: Font.Medium
            color: Appearance.colors.onSurface
        }
    }
}
