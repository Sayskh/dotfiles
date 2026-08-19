import QtQuick
import QtQuick.Layouts
import "../../common"
import "../../common/widgets"
import "../../../services"

Rectangle {
    id: root
    width: 280
    height: 280
    radius: Appearance.rounding.large
    color: Appearance.colors.surfaceContainerHigh
    border.color: Appearance.colors.outlineVariant
    border.width: 1

    readonly property date currentDate: new Date()
    readonly property int currentYear: currentDate.getFullYear()
    readonly property int currentMonth: currentDate.getMonth()
    readonly property int currentDay: currentDate.getDate()

    readonly property var monthNames: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    readonly property var dayHeaders: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        // Header
        RowLayout {
            Layout.fillWidth: true
            Text {
                text: root.monthNames[root.currentMonth] + " " + root.currentYear
                font.family: Appearance.font.family
                font.pixelSize: Appearance.font.sizeTitle
                font.weight: Font.Bold
                color: Appearance.colors.primary
            }
            Item { Layout.fillWidth: true }
        }

        // Day of week headers
        RowLayout {
            Layout.fillWidth: true
            Repeater {
                model: root.dayHeaders
                Text {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: modelData
                    font.family: Appearance.font.family
                    font.pixelSize: Appearance.font.sizeCaption
                    font.weight: Font.DemiBold
                    color: Appearance.colors.onSurfaceVariant
                }
            }
        }

        // Days Grid
        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: 7
            rows: 6
            rowSpacing: 4
            columnSpacing: 4

            Repeater {
                model: 35
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: Appearance.rounding.full

                    readonly property int firstDayIndex: new Date(root.currentYear, root.currentMonth, 1).getDay()
                    readonly property int dayNumber: index - firstDayIndex + 1
                    readonly property int daysInMonth: new Date(root.currentYear, root.currentMonth + 1, 0).getDate()
                    readonly property bool isValidDay: dayNumber > 0 && dayNumber <= daysInMonth
                    readonly property bool isToday: isValidDay && dayNumber === root.currentDay

                    color: isToday ? Appearance.colors.primary : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: parent.isValidDay ? parent.dayNumber : ""
                        font.family: Appearance.font.family
                        font.pixelSize: Appearance.font.sizeBody
                        font.weight: parent.isToday ? Font.Bold : Font.Normal
                        color: parent.isToday ? Appearance.colors.onPrimary : Appearance.colors.onSurface
                    }
                }
            }
        }
    }
}
