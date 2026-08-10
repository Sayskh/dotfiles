import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../common"
import "../common/widgets"
import "../common/models"

PanelWindow {
    id: searchOverlay

    visible: GlobalStates.searchOpen

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    color: Qt.rgba(0, 0, 0, 0.4)

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    // Dismiss on background click
    MouseArea {
        anchors.fill: parent
        onClicked: GlobalStates.searchOpen = false
    }

    // Main M3 Search Card
    MaterialShape {
        anchors.centerIn: parent
        width: 560
        height: 400
        radius: Appearance.rounding.extraLarge
        color: Appearance.m3colors.m3surfaceContainerHigh

        // Prevent clicks inside card from closing backdrop
        MouseArea {
            anchors.fill: parent
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 16

            // Search Bar Input Header
            MaterialShape {
                Layout.fillWidth: true
                implicitHeight: 52
                radius: Appearance.rounding.full
                color: Appearance.m3colors.m3surfaceContainerLowest

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 16
                    anchors.rightMargin: 16
                    spacing: 12

                    MaterialSymbol {
                        icon: "search"
                        size: 22
                        color: Appearance.m3colors.m3primary
                    }

                    TextInput {
                        id: searchInput
                        Layout.fillWidth: true
                        font.family: Appearance.font.family
                        font.pixelSize: 15
                        color: Appearance.m3colors.m3onSurface
                        focus: searchOverlay.visible

                        Text {
                            text: "Type to search apps and commands..."
                            color: Appearance.m3colors.m3onSurfaceVariant
                            font: searchInput.font
                            visible: !searchInput.text && !searchInput.inputMethodComposing
                        }

                        Keys.onEscapePressed: GlobalStates.searchOpen = false
                    }
                }
            }

            // Quick App Launch Grid
            Text {
                text: "Quick Launch"
                color: Appearance.m3colors.m3onSurfaceVariant
                font.family: Appearance.font.family
                font.pixelSize: 12
                font.weight: Font.Bold
            }

            GridLayout {
                columns: 2
                columnSpacing: 12
                rowSpacing: 12
                Layout.fillWidth: true

                component QuickAppButton : MouseArea {
                    id: btn
                    required property string label
                    required property string iconName
                    required property string execCmd

                    implicitWidth: 240
                    implicitHeight: 48
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true

                    onClicked: {
                        WMInterface.launchApp(execCmd);
                        GlobalStates.searchOpen = false;
                    }

                    MaterialShape {
                        anchors.fill: parent
                        radius: Appearance.rounding.medium
                        color: btn.containsMouse ? Appearance.m3colors.m3surfaceBright : Appearance.m3colors.m3surfaceContainer

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 16
                            anchors.rightMargin: 16
                            spacing: 12

                            MaterialSymbol {
                                icon: btn.iconName
                                size: 20
                                color: Appearance.m3colors.m3primary
                            }

                            Text {
                                text: btn.label
                                color: Appearance.m3colors.m3onSurface
                                font.family: Appearance.font.family
                                font.pixelSize: 13
                                font.weight: Font.Medium
                            }
                        }
                    }
                }

                QuickAppButton { label: "Zen Browser"; iconName: "web"; execCmd: "zen-browser" }
                QuickAppButton { label: "Kitty Terminal"; iconName: "terminal"; execCmd: "kitty" }
                QuickAppButton { label: "Thunar Files"; iconName: "folder"; execCmd: "thunar" }
                QuickAppButton { label: "Vesktop Discord"; iconName: "chat"; execCmd: "vesktop" }
                QuickAppButton { label: "Spotify"; iconName: "music_note"; execCmd: "spotify" }
                QuickAppButton { label: "Neovim"; iconName: "code"; execCmd: "kitty -e nvim" }
            }

            Item { Layout.fillHeight: true }
        }
    }
}
