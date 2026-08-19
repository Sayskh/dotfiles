import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import "../../common"
import "../../common/widgets"
import "../../../services"

Rectangle {
    id: root
    width: 380
    height: 160
    radius: Appearance.rounding.large
    color: Appearance.colors.surfaceContainerHigh
    border.color: Appearance.colors.outlineVariant
    border.width: 1

    RowLayout {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 16

        // Album Art
        Rectangle {
            Layout.preferredWidth: 132
            Layout.preferredHeight: 132
            radius: Appearance.rounding.medium
            color: Appearance.colors.surfaceContainerHighest
            clip: true

            Image {
                anchors.fill: parent
                source: MprisController.artUrl
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.color: Appearance.colors.outlineVariant
                border.width: 1
                radius: parent.radius
            }
        }

        // Info & Controls
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 6

            Text {
                Layout.fillWidth: true
                text: MprisController.title
                font.family: Appearance.font.family
                font.pixelSize: Appearance.font.sizeBody
                font.weight: Font.Bold
                color: Appearance.colors.onSurface
                elide: Text.ElideRight
            }

            Text {
                Layout.fillWidth: true
                text: MprisController.artist
                font.family: Appearance.font.family
                font.pixelSize: Appearance.font.sizeCaption
                color: Appearance.colors.onSurfaceVariant
                elide: Text.ElideRight
            }

            Item { Layout.fillHeight: true }

            // Progress bar
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 4
                radius: 2
                color: Appearance.colors.surfaceContainerHighest

                Rectangle {
                    height: parent.height
                    width: parent.width * MprisController.progress
                    radius: 2
                    color: Appearance.colors.primary
                }
            }

            // Controls
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 12

                MaterialSymbol {
                    icon: "skip_previous"
                    iconSize: 22
                    color: Appearance.colors.onSurface
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: MprisController.previous()
                    }
                }

                Rectangle {
                    width: 36
                    height: 36
                    radius: 18
                    color: Appearance.colors.primaryContainer

                    MaterialSymbol {
                        anchors.centerIn: parent
                        icon: MprisController.isPlaying ? "pause" : "play_arrow"
                        iconSize: 20
                        color: Appearance.colors.onPrimaryContainer
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: MprisController.togglePlaying()
                    }
                }

                MaterialSymbol {
                    icon: "skip_next"
                    iconSize: 22
                    color: Appearance.colors.onSurface
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: MprisController.next()
                    }
                }
            }
        }
    }
}
