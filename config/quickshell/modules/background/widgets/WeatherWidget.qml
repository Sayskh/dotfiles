import QtQuick
import QtQuick.Layouts
import "../../common"
import "../../common/widgets"
import "../../../services"

Rectangle {
    id: root
    width: 150
    height: 120
    radius: Appearance.rounding.large
    color: Appearance.colors.surfaceContainerHigh
    border.color: Appearance.colors.outlineVariant
    border.width: 1

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 4

        // Location
        RowLayout {
            spacing: 4
            MaterialSymbol {
                icon: "location_on"
                iconSize: 13
                color: Appearance.colors.onSurfaceVariant
            }
            Text {
                text: Weather.city || "Cuenca"
                font.family: Appearance.font.family
                font.pixelSize: 11
                font.weight: Font.Medium
                color: Appearance.colors.onSurfaceVariant
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }

        // Temp & Weather Icon
        RowLayout {
            Layout.fillWidth: true
            Text {
                text: (Weather.temp || "12") + "°C"
                font.family: Appearance.font.family
                font.pixelSize: 26
                font.weight: Font.Bold
                color: Appearance.colors.onSurface
            }

            Item { Layout.fillWidth: true }

            Rectangle {
                width: 32
                height: 32
                radius: 16
                color: Appearance.colors.primaryContainer

                MaterialSymbol {
                    anchors.centerIn: parent
                    icon: Weather.icon || "cloud"
                    iconSize: 18
                    color: Appearance.colors.onPrimaryContainer
                }
            }
        }

        // Condition description
        Text {
            text: Weather.condition || "broken clouds"
            font.family: Appearance.font.family
            font.pixelSize: 10
            color: Appearance.colors.onSurfaceVariant
            elide: Text.ElideRight
            Layout.fillWidth: true
        }

        // Stats (Humidity & Wind)
        RowLayout {
            spacing: 8
            RowLayout {
                spacing: 2
                MaterialSymbol {
                    icon: "water_drop"
                    iconSize: 11
                    color: Appearance.colors.secondary
                }
                Text {
                    text: (Weather.humidity || "90") + "%"
                    font.family: Appearance.font.family
                    font.pixelSize: 9
                    color: Appearance.colors.onSurfaceVariant
                }
            }

            RowLayout {
                spacing: 2
                MaterialSymbol {
                    icon: "air"
                    iconSize: 11
                    color: Appearance.colors.secondary
                }
                Text {
                    text: (Weather.windSpeed || "1.39") + " m/s"
                    font.family: Appearance.font.family
                    font.pixelSize: 9
                    color: Appearance.colors.onSurfaceVariant
                }
            }
        }
    }
}
