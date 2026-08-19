import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../../common"
import "../../common/widgets"
import "../../../services"

ScrollView {
    id: root
    contentWidth: availableWidth
    clip: true

    property var leftModules: Config.options.bar?.leftModules ?? ["Media"]
    property var centerModules: Config.options.bar?.centerModules ?? ["Left Sidebar Button", "Dock to Panel", "Util Buttons"]
    property var rightModules: Config.options.bar?.rightModules ?? ["Clock"]

    readonly property var allAvailableModules: [
        { name: "Workspaces", icon: "more_horiz" },
        { name: "Weather", icon: "sunny" },
        { name: "Resources", icon: "memory" },
        { name: "System Icons", icon: "info" },
        { name: "Tray", icon: "inventory_2" },
        { name: "Battery", icon: "battery_charging_full" },
        { name: "Active Window", icon: "tab" },
        { name: "Power Button", icon: "power_settings_new" },
        { name: "Updates", icon: "sync" },
        { name: "Visualizer", icon: "graphic_eq" },
        { name: "Keyboard Layout", icon: "keyboard" }
    ]

    property string barPosition: Config.options.bar?.position ?? "Bottom"
    property string barStyle: Config.options.bar?.style ?? "M3"
    property string autoHide: Config.options.bar?.autoHide ? "Yes" : "No"
    property string groupStyle: Config.options.bar?.groupStyle ?? "Pills"

    ColumnLayout {
        width: parent.width
        spacing: 24

        // ── Section 1: Bar Layout ──
        RowLayout {
            spacing: 8
            MaterialSymbol {
                icon: "view_sidebar"
                iconSize: 20
                color: Appearance.colors.primary
            }
            Text {
                text: "Bar layout"
                font.family: Appearance.font.family
                font.pixelSize: 18
                font.weight: Font.Bold
                color: Appearance.colors.onSurface
            }
        }

        // Left Section
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 8

            Text {
                text: "Left"
                font.family: Appearance.font.family
                font.pixelSize: 13
                font.weight: Font.DemiBold
                color: Appearance.colors.onSurfaceVariant
            }

            Flow {
                Layout.fillWidth: true
                spacing: 8

                Repeater {
                    model: root.leftModules
                    Rectangle {
                        height: 32
                        width: chipRow.implicitWidth + 20
                        radius: 16
                        color: Appearance.colors.surfaceContainerHighest
                        border.color: Appearance.colors.outlineVariant

                        RowLayout {
                            id: chipRow
                            anchors.centerIn: parent
                            spacing: 6

                            MaterialSymbol {
                                icon: "close"
                                iconSize: 14
                                color: Appearance.colors.onSurfaceVariant
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        let list = [...root.leftModules];
                                        list.splice(index, 1);
                                        Config.setNestedValue("bar.leftModules", list);
                                        root.leftModules = list;
                                    }
                                }
                            }

                            Text {
                                text: modelData
                                font.family: Appearance.font.family
                                font.pixelSize: 12
                                font.weight: Font.Medium
                                color: Appearance.colors.onSurface
                            }
                        }
                    }
                }
            }
        }

        // Center Section
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 8

            Text {
                text: "Center"
                font.family: Appearance.font.family
                font.pixelSize: 13
                font.weight: Font.DemiBold
                color: Appearance.colors.onSurfaceVariant
            }

            Flow {
                Layout.fillWidth: true
                spacing: 8

                Repeater {
                    model: root.centerModules
                    Rectangle {
                        height: 32
                        width: centerChipRow.implicitWidth + 20
                        radius: 16
                        color: Appearance.colors.surfaceContainerHighest
                        border.color: Appearance.colors.outlineVariant

                        RowLayout {
                            id: centerChipRow
                            anchors.centerIn: parent
                            spacing: 6

                            MaterialSymbol {
                                icon: "close"
                                iconSize: 14
                                color: Appearance.colors.onSurfaceVariant
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        let list = [...root.centerModules];
                                        list.splice(index, 1);
                                        Config.setNestedValue("bar.centerModules", list);
                                        root.centerModules = list;
                                    }
                                }
                            }

                            Text {
                                text: modelData
                                font.family: Appearance.font.family
                                font.pixelSize: 12
                                font.weight: Font.Medium
                                color: Appearance.colors.onSurface
                            }
                        }
                    }
                }
            }
        }

        // Available Modules Pool
        Rectangle {
            Layout.fillWidth: true
            radius: Appearance.rounding.large
            color: Appearance.colors.surfaceContainer
            border.color: Appearance.colors.outlineVariant
            border.width: 1
            implicitHeight: poolFlow.implicitHeight + 24

            Flow {
                id: poolFlow
                anchors.fill: parent
                anchors.margins: 12
                spacing: 8

                Repeater {
                    model: root.allAvailableModules
                    Rectangle {
                        height: 32
                        width: poolChip.implicitWidth + 20
                        radius: 16
                        color: Appearance.colors.surfaceContainerHigh
                        border.color: Appearance.colors.outlineVariant

                        RowLayout {
                            id: poolChip
                            anchors.centerIn: parent
                            spacing: 6

                            MaterialSymbol {
                                icon: modelData.icon
                                iconSize: 16
                                color: Appearance.colors.primary
                            }

                            Text {
                                text: modelData.name
                                font.family: Appearance.font.family
                                font.pixelSize: 12
                                font.weight: Font.Medium
                                color: Appearance.colors.onSurface
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                let list = [...root.centerModules, modelData.name];
                                Config.setNestedValue("bar.centerModules", list);
                                root.centerModules = list;
                            }
                        }
                    }
                }
            }
        }

        // Right Section
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 8

            Text {
                text: "Right"
                font.family: Appearance.font.family
                font.pixelSize: 13
                font.weight: Font.DemiBold
                color: Appearance.colors.onSurfaceVariant
            }

            Flow {
                Layout.fillWidth: true
                spacing: 8

                Repeater {
                    model: root.rightModules
                    Rectangle {
                        height: 32
                        width: rightChipRow.implicitWidth + 20
                        radius: 16
                        color: Appearance.colors.surfaceContainerHighest
                        border.color: Appearance.colors.outlineVariant

                        RowLayout {
                            id: rightChipRow
                            anchors.centerIn: parent
                            spacing: 6

                            MaterialSymbol {
                                icon: "close"
                                iconSize: 14
                                color: Appearance.colors.onSurfaceVariant
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        let list = [...root.rightModules];
                                        list.splice(index, 1);
                                        Config.setNestedValue("bar.rightModules", list);
                                        root.rightModules = list;
                                    }
                                }
                            }

                            Text {
                                text: modelData
                                font.family: Appearance.font.family
                                font.pixelSize: 12
                                font.weight: Font.Medium
                                color: Appearance.colors.onSurface
                            }
                        }
                    }
                }
            }
        }

        // ── Section 2: Positioning ──
        RowLayout {
            spacing: 8
            MaterialSymbol {
                icon: "dashboard_customize"
                iconSize: 20
                color: Appearance.colors.primary
            }
            Text {
                text: "Positioning"
                font.family: Appearance.font.family
                font.pixelSize: 18
                font.weight: Font.Bold
                color: Appearance.colors.onSurface
            }
        }

        // Bar Position Controls
        RowLayout {
            Layout.fillWidth: true
            spacing: 24

            ColumnLayout {
                spacing: 6
                Text {
                    text: "Bar position"
                    font.family: Appearance.font.family
                    font.pixelSize: 12
                    color: Appearance.colors.onSurfaceVariant
                }

                RowLayout {
                    spacing: 4
                    Repeater {
                        model: [
                            { id: "Top", icon: "north", label: "Top" },
                            { id: "Left", icon: "west", label: "Left" },
                            { id: "Bottom", icon: "south", label: "Bottom" },
                            { id: "Right", icon: "east", label: "Right" }
                        ]
                        Rectangle {
                            height: 36
                            width: posBtnRow.implicitWidth + 24
                            radius: 18
                            color: root.barPosition === modelData.id ? Appearance.colors.primaryContainer : Appearance.colors.surfaceContainerHighest
                            border.color: Appearance.colors.outlineVariant

                            RowLayout {
                                id: posBtnRow
                                anchors.centerIn: parent
                                spacing: 4
                                MaterialSymbol {
                                    icon: modelData.icon
                                    iconSize: 16
                                    color: root.barPosition === modelData.id ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface
                                }
                                Text {
                                    text: modelData.label
                                    font.family: Appearance.font.family
                                    font.pixelSize: 12
                                    font.weight: root.barPosition === modelData.id ? Font.Bold : Font.Normal
                                    color: root.barPosition === modelData.id ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    root.barPosition = modelData.id;
                                    Config.setNestedValue("bar.position", modelData.id);
                                }
                            }
                        }
                    }
                }
            }

            ColumnLayout {
                spacing: 6
                Text {
                    text: "Automatically hide"
                    font.family: Appearance.font.family
                    font.pixelSize: 12
                    color: Appearance.colors.onSurfaceVariant
                }

                RowLayout {
                    spacing: 4
                    Repeater {
                        model: [
                            { id: "No", icon: "close", label: "No" },
                            { id: "Yes", icon: "check", label: "Yes" }
                        ]
                        Rectangle {
                            height: 36
                            width: hideBtnRow.implicitWidth + 24
                            radius: 18
                            color: root.autoHide === modelData.id ? Appearance.colors.primaryContainer : Appearance.colors.surfaceContainerHighest
                            border.color: Appearance.colors.outlineVariant

                            RowLayout {
                                id: hideBtnRow
                                anchors.centerIn: parent
                                spacing: 4
                                MaterialSymbol {
                                    icon: modelData.icon
                                    iconSize: 16
                                    color: root.autoHide === modelData.id ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface
                                }
                                Text {
                                    text: modelData.label
                                    font.family: Appearance.font.family
                                    font.pixelSize: 12
                                    font.weight: root.autoHide === modelData.id ? Font.Bold : Font.Normal
                                    color: root.autoHide === modelData.id ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    root.autoHide = modelData.id;
                                    Config.setNestedValue("bar.autoHide", modelData.id === "Yes");
                                }
                            }
                        }
                    }
                }
            }
        }

        // Bar Style Controls
        RowLayout {
            Layout.fillWidth: true
            spacing: 24

            ColumnLayout {
                spacing: 6
                Text {
                    text: "Bar style"
                    font.family: Appearance.font.family
                    font.pixelSize: 12
                    color: Appearance.colors.onSurfaceVariant
                }

                RowLayout {
                    spacing: 4
                    Repeater {
                        model: [
                            { id: "Hug", icon: "straighten", label: "Hug" },
                            { id: "Float", icon: "crop_square", label: "Float" },
                            { id: "Islands", icon: "tab_unselected", label: "Islands" },
                            { id: "M3", icon: "view_agenda", label: "M3" }
                        ]
                        Rectangle {
                            height: 36
                            width: styleBtnRow.implicitWidth + 24
                            radius: 18
                            color: root.barStyle === modelData.id ? Appearance.colors.primaryContainer : Appearance.colors.surfaceContainerHighest
                            border.color: Appearance.colors.outlineVariant

                            RowLayout {
                                id: styleBtnRow
                                anchors.centerIn: parent
                                spacing: 4
                                MaterialSymbol {
                                    icon: modelData.icon
                                    iconSize: 16
                                    color: root.barStyle === modelData.id ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface
                                }
                                Text {
                                    text: modelData.label
                                    font.family: Appearance.font.family
                                    font.pixelSize: 12
                                    font.weight: root.barStyle === modelData.id ? Font.Bold : Font.Normal
                                    color: root.barStyle === modelData.id ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    root.barStyle = modelData.id;
                                    Config.setNestedValue("bar.style", modelData.id);
                                }
                            }
                        }
                    }
                }
            }

            ColumnLayout {
                spacing: 6
                Text {
                    text: "Group style"
                    font.family: Appearance.font.family
                    font.pixelSize: 12
                    color: Appearance.colors.onSurfaceVariant
                }

                RowLayout {
                    spacing: 4
                    Repeater {
                        model: [
                            { id: "None", icon: "block", label: "None" },
                            { id: "Pills", icon: "link", label: "Pills" },
                            { id: "Separated", icon: "view_column", label: "Separated" }
                        ]
                        Rectangle {
                            height: 36
                            width: groupBtnRow.implicitWidth + 24
                            radius: 18
                            color: root.groupStyle === modelData.id ? Appearance.colors.primaryContainer : Appearance.colors.surfaceContainerHighest
                            border.color: Appearance.colors.outlineVariant

                            RowLayout {
                                id: groupBtnRow
                                anchors.centerIn: parent
                                spacing: 4
                                MaterialSymbol {
                                    icon: modelData.icon
                                    iconSize: 16
                                    color: root.groupStyle === modelData.id ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface
                                }
                                Text {
                                    text: modelData.label
                                    font.family: Appearance.font.family
                                    font.pixelSize: 12
                                    font.weight: root.groupStyle === modelData.id ? Font.Bold : Font.Normal
                                    color: root.groupStyle === modelData.id ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    root.groupStyle = modelData.id;
                                    Config.setNestedValue("bar.groupStyle", modelData.id);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
