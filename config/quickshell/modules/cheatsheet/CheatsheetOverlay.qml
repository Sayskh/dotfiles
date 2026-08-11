import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../common"
import "../common/widgets"
import "../common/models"

PanelWindow {
    id: cheatsheetOverlay

    visible: GlobalStates.cheatsheetOpen

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    color: Qt.rgba(0, 0, 0, 0.45)

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    // Dismiss on backdrop click
    MouseArea {
        anchors.fill: parent
        onClicked: GlobalStates.cheatsheetOpen = false
    }

    // Main M3 Card
    MaterialShape {
        anchors.centerIn: parent
        width: 720
        height: 520
        radius: Appearance.rounding.extraLarge
        color: Appearance.m3colors.m3surfaceContainerHigh
        border.color: Qt.rgba(1, 1, 1, 0.08)
        border.width: 1

        MouseArea {
            anchors.fill: parent
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 16

            // Header
            RowLayout {
                Layout.fillWidth: true

                MaterialSymbol {
                    icon: "keyboard"
                    size: 26
                    color: Appearance.m3colors.m3primary
                }

                Text {
                    text: "Keybindings Cheatsheet"
                    color: Appearance.m3colors.m3onSurface
                    font.family: Appearance.font.family
                    font.pixelSize: 18
                    font.weight: Font.Bold
                    Layout.fillWidth: true
                }

                MouseArea {
                    implicitWidth: 32
                    implicitHeight: 32
                    cursorShape: Qt.PointingHandCursor
                    onClicked: GlobalStates.cheatsheetOpen = false

                    MaterialSymbol {
                        anchors.centerIn: parent
                        icon: "close"
                        size: 20
                        color: Appearance.m3colors.m3onSurfaceVariant
                    }
                }
            }

            // Keybindings Grid (2 Columns)
            GridLayout {
                columns: 2
                columnSpacing: 20
                rowSpacing: 16
                Layout.fillWidth: true

                component KeyRow : RowLayout {
                    required property string keyCombo
                    required property string description

                    Layout.fillWidth: true
                    spacing: 8

                    MaterialPill {
                        text: keyCombo
                        color: Appearance.m3colors.m3primaryContainer
                        textColor: Appearance.m3colors.m3onPrimaryContainer
                    }

                    Text {
                        text: description
                        color: Appearance.m3colors.m3onSurface
                        font.family: Appearance.font.family
                        font.pixelSize: 12
                        font.weight: Font.Medium
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                    }
                }

                // Group 1: Applications
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    Text {
                        text: "Applications & Launchers"
                        color: Appearance.m3colors.m3primary
                        font.family: Appearance.font.family
                        font.pixelSize: 13
                        font.weight: Font.Bold
                    }

                    KeyRow { keyCombo: "SUPER + Enter"; description: "Open Kitty Terminal" }
                    KeyRow { keyCombo: "SUPER + B"; description: "Open Zen Browser" }
                    KeyRow { keyCombo: "SUPER + E"; description: "Open Thunar File Manager" }
                    KeyRow { keyCombo: "SUPER + D"; description: "M3 App Launcher Overlay" }
                    KeyRow { keyCombo: "SUPER + /"; description: "Toggle Keybinds Cheatsheet" }
                }

                // Group 2: Window Control
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    Text {
                        text: "Window Management"
                        color: Appearance.m3colors.m3primary
                        font.family: Appearance.font.family
                        font.pixelSize: 13
                        font.weight: Font.Bold
                    }

                    KeyRow { keyCombo: "SUPER + Q"; description: "Close Active Window" }
                    KeyRow { keyCombo: "SUPER + Shift + Space"; description: "Toggle Floating Window" }
                    KeyRow { keyCombo: "SUPER + F"; description: "Toggle Fullscreen Mode" }
                    KeyRow { keyCombo: "SUPER + H / J / K / L"; description: "Navigate Focus (Left/Down/Up/Right)" }
                }

                // Group 3: Workspaces
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    Text {
                        text: "Tags & Workspaces"
                        color: Appearance.m3colors.m3primary
                        font.family: Appearance.font.family
                        font.pixelSize: 13
                        font.weight: Font.Bold
                    }

                    KeyRow { keyCombo: "SUPER + 1..9"; description: "Switch to Tag 1 - 9" }
                    KeyRow { keyCombo: "SUPER + Shift + 1..9"; description: "Move Window to Tag 1 - 9" }
                }

                // Group 4: Media & System
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    Text {
                        text: "Media & System Controls"
                        color: Appearance.m3colors.m3primary
                        font.family: Appearance.font.family
                        font.pixelSize: 13
                        font.weight: Font.Bold
                    }

                    KeyRow { keyCombo: "Volume Up / Down / Mute"; description: "Adjust Sound (OSD Feedback)" }
                    KeyRow { keyCombo: "Brightness Up / Down"; description: "Adjust Screen Brightness" }
                }
            }

            Item { Layout.fillHeight: true }
        }
    }

    Shortcut {
        sequence: "Escape"
        onActivated: GlobalStates.cheatsheetOpen = false
    }
}
