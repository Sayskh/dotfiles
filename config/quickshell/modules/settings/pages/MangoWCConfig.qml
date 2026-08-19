import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import "../../common"
import "../../common/widgets"
import "../../../services"

ScrollView {
    id: root
    contentWidth: availableWidth
    clip: true

    property int gapsIn: 6
    property int gapsOut: 12
    property int borderSize: 2
    property int cornerRadius: 16
    property bool blurEnable: true
    property int blurPasses: 3
    property bool shadowsEnable: true
    property string activeLayout: "scroller"

    function saveMangoWCConfig() {
        const cmd = `sed -i 's/^gaps_in = .*/gaps_in = ${root.gapsIn}/' ~/.config/mangowc/config 2>/dev/null; \
                     sed -i 's/^gaps_out = .*/gaps_out = ${root.gapsOut}/' ~/.config/mangowc/config 2>/dev/null; \
                     sed -i 's/^border_size = .*/border_size = ${root.borderSize}/' ~/.config/mangowc/config 2>/dev/null; \
                     sed -i 's/^corner_radius = .*/corner_radius = ${root.cornerRadius}/' ~/.config/mangowc/config 2>/dev/null; \
                     sed -i 's/^layout = .*/layout = ${root.activeLayout}/' ~/.config/mangowc/config 2>/dev/null; \
                     mmsg -r 2>/dev/null || true`;
        Quickshell.execDetached(["sh", "-c", cmd]);
    }

    ColumnLayout {
        width: parent.width
        spacing: 20

        // Header
        RowLayout {
            spacing: 8
            MaterialSymbol {
                icon: "terminal"
                iconSize: 22
                color: Appearance.colors.primary
            }
            Text {
                text: "MangoWC Compositor"
                font.family: Appearance.font.family
                font.pixelSize: 18
                font.weight: Font.Bold
                color: Appearance.colors.onSurface
            }
        }

        // Layout Selector
        ColumnLayout {
            spacing: 6
            Text {
                text: "Default Window Layout"
                font.family: Appearance.font.family
                font.pixelSize: 12
                color: Appearance.colors.onSurfaceVariant
            }

            RowLayout {
                spacing: 8
                Repeater {
                    model: [
                        { id: "scroller", icon: "view_carousel", label: "Scroller (Niri-style)" },
                        { id: "master", icon: "view_agenda", label: "Master & Stack" },
                        { id: "dwindle", icon: "dashboard", label: "Dwindle" }
                    ]
                    Rectangle {
                        height: 36
                        width: layoutRow.implicitWidth + 24
                        radius: 18
                        color: root.activeLayout === modelData.id ? Appearance.colors.primaryContainer : Appearance.colors.surfaceContainerHighest
                        border.color: Appearance.colors.outlineVariant

                        RowLayout {
                            id: layoutRow
                            anchors.centerIn: parent
                            spacing: 6
                            MaterialSymbol {
                                icon: modelData.icon
                                iconSize: 16
                                color: root.activeLayout === modelData.id ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface
                            }
                            Text {
                                text: modelData.label
                                font.family: Appearance.font.family
                                font.pixelSize: 12
                                font.weight: root.activeLayout === modelData.id ? Font.Bold : Font.Normal
                                color: root.activeLayout === modelData.id ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root.activeLayout = modelData.id;
                                root.saveMangoWCConfig();
                            }
                        }
                    }
                }
            }
        }

        // Gaps & Window Geometry
        Text {
            text: "Gaps & Geometry"
            font.family: Appearance.font.family
            font.pixelSize: 14
            font.weight: Font.Bold
            color: Appearance.colors.primary
        }

        // Inner Gaps Stepper
        RowLayout {
            Layout.fillWidth: true
            Text { text: "Inner Gaps (Window spacing)"; font.pixelSize: 13; color: Appearance.colors.onSurface; Layout.fillWidth: true }
            Rectangle {
                width: 28; height: 28; radius: 14; color: Appearance.colors.surfaceContainerHighest
                Text { anchors.centerIn: parent; text: "−"; font.pixelSize: 16; color: Appearance.colors.onSurface }
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: { root.gapsIn = Math.max(0, root.gapsIn - 2); root.saveMangoWCConfig(); } }
            }
            Text { text: root.gapsIn + " px"; font.pixelSize: 13; font.weight: Font.Bold; color: Appearance.colors.onSurface; Layout.preferredWidth: 60; horizontalAlignment: Text.AlignHCenter }
            Rectangle {
                width: 28; height: 28; radius: 14; color: Appearance.colors.surfaceContainerHighest
                Text { anchors.centerIn: parent; text: "+"; font.pixelSize: 16; color: Appearance.colors.onSurface }
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: { root.gapsIn += 2; root.saveMangoWCConfig(); } }
            }
        }

        // Outer Gaps Stepper
        RowLayout {
            Layout.fillWidth: true
            Text { text: "Outer Gaps (Screen margin)"; font.pixelSize: 13; color: Appearance.colors.onSurface; Layout.fillWidth: true }
            Rectangle {
                width: 28; height: 28; radius: 14; color: Appearance.colors.surfaceContainerHighest
                Text { anchors.centerIn: parent; text: "−"; font.pixelSize: 16; color: Appearance.colors.onSurface }
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: { root.gapsOut = Math.max(0, root.gapsOut - 2); root.saveMangoWCConfig(); } }
            }
            Text { text: root.gapsOut + " px"; font.pixelSize: 13; font.weight: Font.Bold; color: Appearance.colors.onSurface; Layout.preferredWidth: 60; horizontalAlignment: Text.AlignHCenter }
            Rectangle {
                width: 28; height: 28; radius: 14; color: Appearance.colors.surfaceContainerHighest
                Text { anchors.centerIn: parent; text: "+"; font.pixelSize: 16; color: Appearance.colors.onSurface }
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: { root.gapsOut += 2; root.saveMangoWCConfig(); } }
            }
        }

        // Corner Radius Stepper
        RowLayout {
            Layout.fillWidth: true
            Text { text: "Window Corner Radius"; font.pixelSize: 13; color: Appearance.colors.onSurface; Layout.fillWidth: true }
            Rectangle {
                width: 28; height: 28; radius: 14; color: Appearance.colors.surfaceContainerHighest
                Text { anchors.centerIn: parent; text: "−"; font.pixelSize: 16; color: Appearance.colors.onSurface }
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: { root.cornerRadius = Math.max(0, root.cornerRadius - 2); root.saveMangoWCConfig(); } }
            }
            Text { text: root.cornerRadius + " px"; font.pixelSize: 13; font.weight: Font.Bold; color: Appearance.colors.onSurface; Layout.preferredWidth: 60; horizontalAlignment: Text.AlignHCenter }
            Rectangle {
                width: 28; height: 28; radius: 14; color: Appearance.colors.surfaceContainerHighest
                Text { anchors.centerIn: parent; text: "+"; font.pixelSize: 16; color: Appearance.colors.onSurface }
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: { root.cornerRadius += 2; root.saveMangoWCConfig(); } }
            }
        }

        // Scenefx Shaders & Blur
        Text {
            text: "Scenefx Effects & Shaders"
            font.family: Appearance.font.family
            font.pixelSize: 14
            font.weight: Font.Bold
            color: Appearance.colors.primary
        }

        RowLayout {
            Layout.fillWidth: true
            Text { text: "Compositor GPU Blur"; font.pixelSize: 13; color: Appearance.colors.onSurface; Layout.fillWidth: true }
            MouseArea {
                implicitWidth: 44; implicitHeight: 24; cursorShape: Qt.PointingHandCursor
                onClicked: { root.blurEnable = !root.blurEnable; root.saveMangoWCConfig(); }
                Rectangle {
                    anchors.fill: parent; radius: 12; color: root.blurEnable ? Appearance.colors.primary : Appearance.colors.surfaceContainerHighest
                    Rectangle {
                        width: 18; height: 18; radius: 9; anchors.verticalCenter: parent.verticalCenter
                        x: root.blurEnable ? 22 : 4; color: Appearance.colors.onPrimary
                        Behavior on x { NumberAnimation { duration: Appearance.animation.fast } }
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Text { text: "Window Drop Shadows"; font.pixelSize: 13; color: Appearance.colors.onSurface; Layout.fillWidth: true }
            MouseArea {
                implicitWidth: 44; implicitHeight: 24; cursorShape: Qt.PointingHandCursor
                onClicked: { root.shadowsEnable = !root.shadowsEnable; root.saveMangoWCConfig(); }
                Rectangle {
                    anchors.fill: parent; radius: 12; color: root.shadowsEnable ? Appearance.colors.primary : Appearance.colors.surfaceContainerHighest
                    Rectangle {
                        width: 18; height: 18; radius: 9; anchors.verticalCenter: parent.verticalCenter
                        x: root.shadowsEnable ? 22 : 4; color: Appearance.colors.onPrimary
                        Behavior on x { NumberAnimation { duration: Appearance.animation.fast } }
                    }
                }
            }
        }
    }
}
