import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import "../../common"
import "../../common/widgets"
import "../../../services"

ScrollView {
    id: root
    contentWidth: availableWidth
    clip: true

    property int selectedIndex: 0
    property var screens: Quickshell.screens
    property var currentScreen: (screens && screens.length > selectedIndex) ? screens[selectedIndex] : null

    property bool monitorEnabled: true
    property string selectedMode: (currentScreen ? `${currentScreen.width}x${currentScreen.height}@60.00Hz` : "1920x1080@60.00Hz")
    property string orientation: "Normal"
    property int scalePercent: currentScreen ? Math.round(currentScreen.scale * 100) : 100
    property int posX: 0
    property int posY: 0

    readonly property var commonModes: [
        "1920x1080@144.00Hz",
        "1920x1080@60.00Hz",
        "2560x1440@165.00Hz",
        "2560x1440@144.00Hz",
        "2560x1440@60.00Hz",
        "3840x2160@60.00Hz",
        "1440x900@60.00Hz",
        "1366x768@60.00Hz"
    ]

    function applyDisplaySettings() {
        if (!currentScreen) return;
        const screenName = currentScreen.name || "HDMI-A-1";
        const modeParts = root.selectedMode.split("@");
        const res = modeParts[0] || "1920x1080";
        const rate = modeParts[1] ? modeParts[1].replace("Hz", "") : "60.00";
        const scaleVal = (root.scalePercent / 100).toFixed(2);

        let transform = "normal";
        if (root.orientation === "90°") transform = "90";
        else if (root.orientation === "180°") transform = "180";
        else if (root.orientation === "270°") transform = "270";

        const cmd = `wlr-randr --output ${screenName} --mode ${res} --rate ${rate} --pos ${root.posX},${root.posY} --scale ${scaleVal} --transform ${transform}`;
        Quickshell.execDetached(["sh", "-c", cmd]);
    }

    ColumnLayout {
        width: parent.width
        spacing: 20

        // Header
        RowLayout {
            spacing: 8
            MaterialSymbol {
                icon: "monitor"
                iconSize: 22
                color: Appearance.colors.primary
            }
            Text {
                text: "Displays"
                font.family: Appearance.font.family
                font.pixelSize: 18
                font.weight: Font.Bold
                color: Appearance.colors.onSurface
            }
        }

        // ── Visual Display Arrangement Canvas ──
        Rectangle {
            Layout.fillWidth: true
            height: 180
            radius: Appearance.rounding.large
            color: Appearance.colors.surfaceContainer
            border.color: Appearance.colors.outlineVariant
            border.width: 1

            RowLayout {
                anchors.centerIn: parent
                spacing: 16

                Repeater {
                    model: (root.screens && root.screens.length > 0) ? root.screens.length : 2

                    Rectangle {
                        readonly property var scr: (root.screens && root.screens.length > index) ? root.screens[index] : null
                        readonly property string scrName: scr ? (scr.name || `Display-${index+1}`) : (index === 0 ? "HDMI-A-2" : "VGA-1")
                        readonly property string scrRes: scr ? `${scr.width}x${scr.height}` : (index === 0 ? "1920x1080" : "1440x900")
                        readonly property bool isSelected: root.selectedIndex === index

                        width: index === 0 ? 190 : 150
                        height: index === 0 ? 110 : 90
                        radius: Appearance.rounding.medium
                        color: isSelected ? Appearance.colors.primaryContainer : Appearance.colors.surfaceContainerHighest
                        border.color: isSelected ? Appearance.colors.primary : Appearance.colors.outlineVariant
                        border.width: isSelected ? 2 : 1

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 4

                            MaterialSymbol {
                                Layout.alignment: Qt.AlignHCenter
                                icon: "desktop_windows"
                                iconSize: 22
                                color: isSelected ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurfaceVariant
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: parent.parent.scrName
                                font.family: Appearance.font.family
                                font.pixelSize: 12
                                font.weight: Font.Bold
                                color: isSelected ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: parent.parent.scrRes
                                font.family: Appearance.font.family
                                font.pixelSize: 10
                                color: isSelected ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurfaceVariant
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root.selectedIndex = index;
                            }
                        }
                    }
                }
            }
        }

        // ── Selected Monitor Details ──
        Text {
            text: (root.currentScreen ? `${root.currentScreen.name || "Display"} • ${root.currentScreen.model || "Connected Monitor"}` : "HDMI-A-2 • Ancor Communications Inc MX259")
            font.family: Appearance.font.family
            font.pixelSize: 13
            font.weight: Font.Medium
            color: Appearance.colors.onSurfaceVariant
        }

        // Enable Toggle
        RowLayout {
            Layout.fillWidth: true
            RowLayout {
                spacing: 8
                MaterialSymbol {
                    icon: "visibility"
                    iconSize: 18
                    color: Appearance.colors.onSurfaceVariant
                }
                Text {
                    text: "Enabled"
                    font.family: Appearance.font.family
                    font.pixelSize: 13
                    color: Appearance.colors.onSurface
                }
            }

            Item { Layout.fillWidth: true }

            MouseArea {
                implicitWidth: 44
                implicitHeight: 24
                cursorShape: Qt.PointingHandCursor
                onClicked: root.monitorEnabled = !root.monitorEnabled
                Rectangle {
                    anchors.fill: parent
                    radius: 12
                    color: root.monitorEnabled ? Appearance.colors.primary : Appearance.colors.surfaceContainerHighest
                    Rectangle {
                        width: 18; height: 18; radius: 9
                        anchors.verticalCenter: parent.verticalCenter
                        x: root.monitorEnabled ? 22 : 4
                        color: Appearance.colors.onPrimary
                        Behavior on x { NumberAnimation { duration: Appearance.animation.fast } }
                    }
                }
            }
        }

        // Resolution & Refresh Rate
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 6

            Text {
                text: "Resolution & Refresh Rate"
                font.family: Appearance.font.family
                font.pixelSize: 12
                color: Appearance.colors.onSurfaceVariant
            }

            Rectangle {
                Layout.fillWidth: true
                height: 40
                radius: Appearance.rounding.medium
                color: Appearance.colors.surfaceContainerHigh
                border.color: Appearance.colors.outlineVariant

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 8

                    MaterialSymbol {
                        icon: "aspect_ratio"
                        iconSize: 18
                        color: Appearance.colors.primary
                    }

                    Text {
                        text: root.selectedMode
                        font.family: Appearance.font.family
                        font.pixelSize: 13
                        color: Appearance.colors.onSurface
                        Layout.fillWidth: true
                    }

                    MaterialSymbol {
                        icon: "expand_more"
                        iconSize: 18
                        color: Appearance.colors.onSurfaceVariant
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        let nextIdx = (root.commonModes.indexOf(root.selectedMode) + 1) % root.commonModes.length;
                        root.selectedMode = root.commonModes[nextIdx];
                        root.applyDisplaySettings();
                    }
                }
            }
        }

        // Orientation
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 6

            Text {
                text: "Orientation"
                font.family: Appearance.font.family
                font.pixelSize: 12
                color: Appearance.colors.onSurfaceVariant
            }

            RowLayout {
                spacing: 8
                Repeater {
                    model: [
                        { id: "Normal", icon: "screen_rotation_alt", label: "Normal" },
                        { id: "90°", icon: "rotate_90_degrees_cw", label: "90°" },
                        { id: "180°", icon: "rotate_left", label: "180°" },
                        { id: "270°", icon: "rotate_90_degrees_ccw", label: "270°" }
                    ]

                    Rectangle {
                        height: 36
                        width: orientRow.implicitWidth + 24
                        radius: 18
                        color: root.orientation === modelData.id ? Appearance.colors.primaryContainer : Appearance.colors.surfaceContainerHighest
                        border.color: Appearance.colors.outlineVariant

                        RowLayout {
                            id: orientRow
                            anchors.centerIn: parent
                            spacing: 4
                            MaterialSymbol {
                                icon: modelData.icon
                                iconSize: 16
                                color: root.orientation === modelData.id ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface
                            }
                            Text {
                                text: modelData.label
                                font.family: Appearance.font.family
                                font.pixelSize: 12
                                font.weight: root.orientation === modelData.id ? Font.Bold : Font.Normal
                                color: root.orientation === modelData.id ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root.orientation = modelData.id;
                                root.applyDisplaySettings();
                            }
                        }
                    }
                }
            }
        }

        // Scale & Position Steppers
        RowLayout {
            Layout.fillWidth: true
            spacing: 24

            // Scale Stepper
            RowLayout {
                spacing: 12
                MaterialSymbol {
                    icon: "zoom_in"
                    iconSize: 18
                    color: Appearance.colors.onSurfaceVariant
                }
                Text {
                    text: "Scale"
                    font.family: Appearance.font.family
                    font.pixelSize: 13
                    color: Appearance.colors.onSurface
                }
                Rectangle {
                    width: 28; height: 28; radius: 14
                    color: Appearance.colors.surfaceContainerHighest
                    Text { anchors.centerIn: parent; text: "−"; font.pixelSize: 16; color: Appearance.colors.onSurface }
                    MouseArea {
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            root.scalePercent = Math.max(75, root.scalePercent - 25);
                            root.applyDisplaySettings();
                        }
                    }
                }
                Text {
                    text: root.scalePercent + "%"
                    font.family: Appearance.font.family
                    font.pixelSize: 13
                    font.weight: Font.Bold
                    color: Appearance.colors.onSurface
                }
                Rectangle {
                    width: 28; height: 28; radius: 14
                    color: Appearance.colors.surfaceContainerHighest
                    Text { anchors.centerIn: parent; text: "+"; font.pixelSize: 16; color: Appearance.colors.onSurface }
                    MouseArea {
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            root.scalePercent = Math.min(250, root.scalePercent + 25);
                            root.applyDisplaySettings();
                        }
                    }
                }
            }

            // Position X
            RowLayout {
                spacing: 12
                MaterialSymbol {
                    icon: "swap_horiz"
                    iconSize: 18
                    color: Appearance.colors.onSurfaceVariant
                }
                Text {
                    text: "Pos X"
                    font.family: Appearance.font.family
                    font.pixelSize: 13
                    color: Appearance.colors.onSurface
                }
                Rectangle {
                    width: 28; height: 28; radius: 14
                    color: Appearance.colors.surfaceContainerHighest
                    Text { anchors.centerIn: parent; text: "−"; font.pixelSize: 16; color: Appearance.colors.onSurface }
                    MouseArea {
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                        onClicked: { root.posX = Math.max(0, root.posX - 100); root.applyDisplaySettings(); }
                    }
                }
                Text {
                    text: root.posX.toString()
                    font.family: Appearance.font.family
                    font.pixelSize: 13
                    font.weight: Font.Bold
                    color: Appearance.colors.onSurface
                }
                Rectangle {
                    width: 28; height: 28; radius: 14
                    color: Appearance.colors.surfaceContainerHighest
                    Text { anchors.centerIn: parent; text: "+"; font.pixelSize: 16; color: Appearance.colors.onSurface }
                    MouseArea {
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                        onClicked: { root.posX += 100; root.applyDisplaySettings(); }
                    }
                }
            }

            // Position Y
            RowLayout {
                spacing: 12
                MaterialSymbol {
                    icon: "swap_vert"
                    iconSize: 18
                    color: Appearance.colors.onSurfaceVariant
                }
                Text {
                    text: "Pos Y"
                    font.family: Appearance.font.family
                    font.pixelSize: 13
                    color: Appearance.colors.onSurface
                }
                Rectangle {
                    width: 28; height: 28; radius: 14
                    color: Appearance.colors.surfaceContainerHighest
                    Text { anchors.centerIn: parent; text: "−"; font.pixelSize: 16; color: Appearance.colors.onSurface }
                    MouseArea {
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                        onClicked: { root.posY = Math.max(0, root.posY - 100); root.applyDisplaySettings(); }
                    }
                }
                Text {
                    text: root.posY.toString()
                    font.family: Appearance.font.family
                    font.pixelSize: 13
                    font.weight: Font.Bold
                    color: Appearance.colors.onSurface
                }
                Rectangle {
                    width: 28; height: 28; radius: 14
                    color: Appearance.colors.surfaceContainerHighest
                    Text { anchors.centerIn: parent; text: "+"; font.pixelSize: 16; color: Appearance.colors.onSurface }
                    MouseArea {
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                        onClicked: { root.posY += 100; root.applyDisplaySettings(); }
                    }
                }
            }
        }
    }
}
