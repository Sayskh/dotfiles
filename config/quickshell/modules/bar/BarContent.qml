import QtQuick
import QtQuick.Layouts
import "../common"
import "../common/widgets"
import "../common/models"
import "../../services"

RowLayout {
    anchors.fill: parent
    anchors.leftMargin: 16
    anchors.rightMargin: 16
    anchors.topMargin: 4
    anchors.bottomMargin: 4
    spacing: 12

    // ── Left Island / Profile Pill ──
    BarIsland {
        Layout.alignment: Qt.AlignLeft

        // Profile Badge
        RowLayout {
            spacing: 8
            Rectangle {
                width: 24
                height: 24
                radius: 12
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
                spacing: 0
                Text {
                    text: "pc"
                    color: Appearance.colors.onSurface
                    font.family: Appearance.font.family
                    font.pixelSize: 11
                    font.weight: Font.Bold
                }
                Text {
                    text: "NixOS"
                    color: Appearance.colors.onSurfaceVariant
                    font.family: Appearance.font.family
                    font.pixelSize: 9
                }
            }
        }

        Rectangle {
            width: 1
            height: 16
            color: Appearance.colors.outlineVariant
        }

        MouseArea {
            implicitWidth: 28
            implicitHeight: 28
            cursorShape: Qt.PointingHandCursor
            onClicked: GlobalStates.toggleSearch()

            MaterialSymbol {
                anchors.centerIn: parent
                icon: "apps"
                iconSize: 18
                color: Appearance.colors.primary
            }
        }

        WorkspacePills {}
    }

    // ── Center Island: Active Window & Media / Taskbar ──
    BarIsland {
        Layout.alignment: Qt.AlignHCenter
        Layout.maximumWidth: 460

        MaterialSymbol {
            icon: MprisController.isPlaying ? "graphic_eq" : "terminal"
            iconSize: 16
            color: Appearance.colors.primary
        }

        Text {
            text: MprisController.isPlaying ? (MprisController.title + " • " + MprisController.artist) : WMInterface.activeWindowTitle
            color: Appearance.colors.onSurface
            font.family: Appearance.font.family
            font.pixelSize: 12
            font.weight: Font.Medium
            elide: Text.ElideRight
            Layout.fillWidth: true
        }
    }

    // ── Right Island: Date Pill + Clock Pill + Quick Settings ──
    BarIsland {
        Layout.alignment: Qt.AlignRight

        // Date Pill
        Rectangle {
            height: 26
            radius: 13
            color: Appearance.colors.surfaceContainerHighest
            width: dateText.implicitWidth + 16

            Text {
                id: dateText
                anchors.centerIn: parent
                text: DateTime.date
                font.family: Appearance.font.family
                font.pixelSize: 11
                font.weight: Font.Medium
                color: Appearance.colors.onSurface
            }
        }

        // Time Pill
        Rectangle {
            height: 26
            radius: 13
            color: Appearance.colors.primaryContainer
            width: timeText.implicitWidth + 16

            Text {
                id: timeText
                anchors.centerIn: parent
                text: DateTime.time
                font.family: Appearance.font.family
                font.pixelSize: 11
                font.weight: Font.Bold
                color: Appearance.colors.onPrimaryContainer
            }
        }

        QuickSettingsTrigger {}
    }
}
