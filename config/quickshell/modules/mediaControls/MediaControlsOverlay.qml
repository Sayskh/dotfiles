import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../common"
import "../common/widgets"
import "../../services"

PanelWindow {
    id: mediaWindow

    visible: GlobalStates.mediaControlsOpen

    anchors {
        top: true
        horizontalCenter: true
    }

    height: 180
    width: 440
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay

    MaterialShape {
        anchors.fill: parent
        anchors.margins: 12
        radius: Appearance.rounding.extraLarge
        color: Appearance.m3colors.m3surfaceContainerHigh
        border.color: Qt.rgba(1, 1, 1, 0.08)
        border.width: 1

        RowLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 16

            // Album Art Thumbnail
            Rectangle {
                implicitWidth: 100
                implicitHeight: 100
                radius: Appearance.rounding.large
                color: Appearance.m3colors.m3primaryContainer
                clip: true

                Image {
                    anchors.fill: parent
                    source: MprisController.artUrl
                    fillMode: Image.PreserveAspectCrop
                    visible: MprisController.artUrl !== ""
                }

                MaterialSymbol {
                    anchors.centerIn: parent
                    icon: "music_note"
                    size: 36
                    color: Appearance.m3colors.m3onPrimaryContainer
                    visible: MprisController.artUrl === ""
                }
            }

            // Track Details & Controls
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 8

                Text {
                    text: MprisController.title
                    color: Appearance.m3colors.m3onSurface
                    font.family: Appearance.font.family
                    font.pixelSize: 15
                    font.weight: Font.Bold
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }

                Text {
                    text: MprisController.artist
                    color: Appearance.m3colors.m3onSurfaceVariant
                    font.family: Appearance.font.family
                    font.pixelSize: 13
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }

                // Controls Row
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    Item { Layout.fillWidth: true }

                    MouseArea {
                        implicitWidth: 36
                        implicitHeight: 36
                        cursorShape: Qt.PointingHandCursor
                        onClicked: MprisController.previous()

                        MaterialSymbol {
                            anchors.centerIn: parent
                            icon: "skip_previous"
                            size: 24
                            color: Appearance.m3colors.m3primary
                        }
                    }

                    MouseArea {
                        implicitWidth: 44
                        implicitHeight: 44
                        cursorShape: Qt.PointingHandCursor
                        onClicked: MprisController.togglePlaying()

                        MaterialShape {
                            anchors.fill: parent
                            radius: Appearance.rounding.full
                            color: Appearance.m3colors.m3primaryContainer

                            MaterialSymbol {
                                anchors.centerIn: parent
                                icon: MprisController.isPlaying ? "pause" : "play_arrow"
                                size: 24
                                color: Appearance.m3colors.m3onPrimaryContainer
                            }
                        }
                    }

                    MouseArea {
                        implicitWidth: 36
                        implicitHeight: 36
                        cursorShape: Qt.PointingHandCursor
                        onClicked: MprisController.next()

                        MaterialSymbol {
                            anchors.centerIn: parent
                            icon: "skip_next"
                            size: 24
                            color: Appearance.m3colors.m3primary
                        }
                    }

                    Item { Layout.fillWidth: true }
                }
            }
        }
    }
}
