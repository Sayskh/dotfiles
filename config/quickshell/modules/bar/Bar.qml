import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../common"
import "../common/widgets"
import "../common/models"

PanelWindow {
    id: barWindow

    anchors {
        top: true
        left: true
        right: true
    }

    height: Appearance.sizes.barHeight + 8
    color: "transparent"

    // Wayland layer shell properties
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.exclusiveZone: barWindow.height

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        anchors.topMargin: 4
        anchors.bottomMargin: 4
        spacing: 12

        // ── Left Island: Launcher & Tag Selector ──
        BarIsland {
            Layout.alignment: Qt.AlignLeft

            // Launcher Button
            MouseArea {
                implicitWidth: 32
                implicitHeight: 32
                cursorShape: Qt.PointingHandCursor
                onClicked: GlobalStates.toggleSearch()

                MaterialSymbol {
                    anchors.centerIn: parent
                    icon: "apps"
                    size: 20
                    color: Appearance.m3colors.m3primary
                }
            }

            // Tag/Workspace Pills
            RowLayout {
                spacing: 4
                Repeater {
                    model: 9
                    delegate: MouseArea {
                        required property int index
                        implicitWidth: 26
                        implicitHeight: 26
                        cursorShape: Qt.PointingHandCursor
                        onClicked: WMInterface.switchWorkspace(index + 1)

                        Rectangle {
                            anchors.centerIn: parent
                            width: (index + 1) === WMInterface.activeWorkspace ? 22 : 8
                            height: 8
                            radius: 4
                            color: (index + 1) === WMInterface.activeWorkspace 
                                ? Appearance.m3colors.m3primary 
                                : Appearance.m3colors.m3surfaceVariant

                            Behavior on width {
                                NumberAnimation { duration: Appearance.animation.fast }
                            }
                            Behavior on color {
                                ColorAnimation { duration: Appearance.animation.fast }
                            }
                        }
                    }
                }
            }
        }

        // ── Center Island: Active Window Title ──
        BarIsland {
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: 400

            MaterialSymbol {
                icon: "window"
                size: 16
                color: Appearance.m3colors.m3onSurfaceVariant
            }

            Text {
                text: WMInterface.activeWindowTitle
                color: Appearance.m3colors.m3onSurface
                font.family: Appearance.font.family
                font.pixelSize: 13
                font.weight: Font.Medium
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }

        // ── Right Island: Clock & Controls ──
        BarIsland {
            Layout.alignment: Qt.AlignRight

            // Clock
            Text {
                id: clockText
                text: Qt.formatDateTime(new Date(), "HH:mm · ddd, MMM d")
                color: Appearance.m3colors.m3onSurface
                font.family: Appearance.font.family
                font.pixelSize: 13
                font.weight: Font.SemiBold

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: clockText.text = Qt.formatDateTime(new Date(), "HH:mm · ddd, MMM d")
                }
            }

            // Quick Settings Trigger
            MouseArea {
                implicitWidth: 28
                implicitHeight: 28
                cursorShape: Qt.PointingHandCursor
                onClicked: GlobalStates.toggleSidebarRight()

                MaterialSymbol {
                    anchors.centerIn: parent
                    icon: "tune"
                    size: 18
                    color: Appearance.m3colors.m3onSurfaceVariant
                }
            }
        }
    }
}
