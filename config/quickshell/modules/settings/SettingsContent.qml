import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../common"
import "../common/widgets"
import "../../services"
import "./pages"

Rectangle {
    id: root
    anchors.centerIn: parent
    width: 860
    height: 600
    radius: Appearance.rounding.extraLarge
    color: Appearance.colors.surface
    border.color: Appearance.colors.outlineVariant
    border.width: 1
    clip: true

    property string currentTab: "Displays"

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // ── Left Sidebar Navigation ──
        Rectangle {
            Layout.preferredWidth: 230
            Layout.fillHeight: true
            color: Appearance.colors.surfaceContainer
            border.color: Appearance.colors.outlineVariant
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 12

                // Profile Card
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12

                    Rectangle {
                        width: 44
                        height: 44
                        radius: 22
                        color: Appearance.colors.primaryContainer
                        clip: true

                        Image {
                            anchors.fill: parent
                            source: Images.defaultAvatar
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                        }
                    }

                    ColumnLayout {
                        spacing: 2
                        Text {
                            text: "NixOS User"
                            font.family: Appearance.font.family
                            font.pixelSize: 14
                            font.weight: Font.Bold
                            color: Appearance.colors.onSurface
                        }
                        Text {
                            text: "MangoWC Desktop"
                            font.family: Appearance.font.family
                            font.pixelSize: 11
                            color: Appearance.colors.onSurfaceVariant
                        }
                    }
                }

                // Config file button
                Rectangle {
                    Layout.fillWidth: true
                    height: 36
                    radius: 18
                    color: Appearance.colors.surfaceContainerHigh
                    border.color: Appearance.colors.outlineVariant

                    RowLayout {
                        anchors.centerIn: parent
                        spacing: 6
                        MaterialSymbol {
                            icon: "edit_note"
                            iconSize: 16
                            color: Appearance.colors.primary
                        }
                        Text {
                            text: "Config file"
                            font.family: Appearance.font.family
                            font.pixelSize: 12
                            font.weight: Font.Medium
                            color: Appearance.colors.onSurface
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Quickshell.execDetached(["kitty", "-e", "nvim", Config.configFilePath])
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: Appearance.colors.outlineVariant
                }

                // Navigation Tabs List
                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    ColumnLayout {
                        width: parent.width
                        spacing: 4

                        Repeater {
                            model: [
                                { id: "Quick", icon: "tune", label: "Quick" },
                                { id: "General", icon: "widgets", label: "General" },
                                { id: "Bar", icon: "dock", label: "Bar" },
                                { id: "Displays", icon: "desktop_windows", label: "Displays" },
                                { id: "Desktop", icon: "wallpaper", label: "Desktop" },
                                { id: "Interface", icon: "palette", label: "Interface" },
                                { id: "Services", icon: "settings_suggest", label: "Services" },
                                { id: "MangoWC", icon: "terminal", label: "MangoWC" },
                                { id: "About", icon: "info", label: "About" }
                            ]

                            Rectangle {
                                Layout.fillWidth: true
                                height: 38
                                radius: 19
                                color: root.currentTab === modelData.id ? Appearance.colors.secondaryContainer : "transparent"

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.leftMargin: 12
                                    anchors.rightMargin: 12
                                    spacing: 12

                                    MaterialSymbol {
                                        icon: modelData.icon
                                        iconSize: 18
                                        color: root.currentTab === modelData.id ? Appearance.colors.onSecondaryContainer : Appearance.colors.onSurfaceVariant
                                    }

                                    Text {
                                        text: modelData.label
                                        font.family: Appearance.font.family
                                        font.pixelSize: 13
                                        font.weight: root.currentTab === modelData.id ? Font.Bold : Font.Normal
                                        color: root.currentTab === modelData.id ? Appearance.colors.onSecondaryContainer : Appearance.colors.onSurface
                                        Layout.fillWidth: true
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: root.currentTab = modelData.id
                                }
                            }
                        }
                    }
                }
            }
        }

        // ── Right Main Content Area ──
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 16

                // Top Header with Close Button
                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        text: root.currentTab + " Settings"
                        font.family: Appearance.font.family
                        font.pixelSize: 20
                        font.weight: Font.Bold
                        color: Appearance.colors.onSurface
                    }

                    Item { Layout.fillWidth: true }

                    Rectangle {
                        width: 32
                        height: 32
                        radius: 16
                        color: Appearance.colors.surfaceContainerHighest

                        MaterialSymbol {
                            anchors.centerIn: parent
                            icon: "close"
                            iconSize: 18
                            color: Appearance.colors.onSurface
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: GlobalStates.settingsOpen = false
                        }
                    }
                }

                // Page Loader / Stack
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    DisplaysConfig {
                        anchors.fill: parent
                        visible: root.currentTab === "Displays"
                    }

                    BarConfig {
                        anchors.fill: parent
                        visible: root.currentTab === "Bar"
                    }

                    MangoWCConfig {
                        anchors.fill: parent
                        visible: root.currentTab === "MangoWC"
                    }

                    GeneralConfig {
                        anchors.fill: parent
                        visible: root.currentTab === "General" || root.currentTab === "Quick" || root.currentTab === "Desktop" || root.currentTab === "Interface" || root.currentTab === "Services"
                    }

                    AboutConfig {
                        anchors.fill: parent
                        visible: root.currentTab === "About"
                    }
                }
            }
        }
    }
}
