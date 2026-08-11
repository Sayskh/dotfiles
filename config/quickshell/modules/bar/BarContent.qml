import QtQuick
import QtQuick.Layouts
import "../common"
import "../common/widgets"
import "../common/models"

RowLayout {
    anchors.fill: parent
    anchors.leftMargin: 12
    anchors.rightMargin: 12
    anchors.topMargin: 4
    anchors.bottomMargin: 4
    spacing: 12

    // Left Island: Launcher & Tag Selector
    BarIsland {
        Layout.alignment: Qt.AlignLeft

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

        WorkspacePills {}
    }

    // Center Island: Active Window Title
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

    // Right Island: Clock & Controls
    BarIsland {
        Layout.alignment: Qt.AlignRight

        ClockModule {}
        QuickSettingsTrigger {}
    }
}
