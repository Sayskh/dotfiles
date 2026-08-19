import QtQuick
import QtQuick.Layouts
import "../../common"
import "../../common/widgets"
import "../../../services"

Rectangle {
    id: root
    width: 240
    height: 180
    radius: Appearance.rounding.large
    color: Appearance.colors.surfaceContainerHigh
    border.color: Appearance.colors.outlineVariant
    border.width: 1

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        Text {
            text: "Time & Date"
            font.family: Appearance.font.family
            font.pixelSize: Appearance.font.sizeCaption
            font.weight: Font.DemiBold
            color: Appearance.colors.primary
        }

        Text {
            text: DateTime.time
            font.family: Appearance.font.family
            font.pixelSize: 32
            font.weight: Font.Bold
            color: Appearance.colors.onSurface
        }

        Text {
            text: DateTime.date
            font.family: Appearance.font.family
            font.pixelSize: Appearance.font.sizeBody
            color: Appearance.colors.onSurfaceVariant
        }

        Item { Layout.fillHeight: true }

        RowLayout {
            Layout.fillWidth: true
            spacing: 6

            MaterialSymbol {
                icon: "public"
                iconSize: 16
                color: Appearance.colors.secondary
            }

            Text {
                text: "Local Time"
                font.family: Appearance.font.family
                font.pixelSize: Appearance.font.sizeCaption
                color: Appearance.colors.secondary
            }
        }
    }
}
