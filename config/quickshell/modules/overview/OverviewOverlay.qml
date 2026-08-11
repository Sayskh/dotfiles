import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../common"
import "../common/widgets"
import "../common/models"

PanelWindow {
    id: overviewWindow

    visible: GlobalStates.overviewOpen

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    color: Qt.rgba(0, 0, 0, 0.45)

    WlrLayershell.layer: WlrLayer.Overlay

    MouseArea {
        anchors.fill: parent
        onClicked: GlobalStates.overviewOpen = false
    }

    MaterialShape {
        anchors.centerIn: parent
        width: 800
        height: 480
        radius: Appearance.rounding.extraLarge
        color: Appearance.m3colors.m3surfaceContainerHigh

        MouseArea { anchors.fill: parent }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 20

            Text {
                text: "Workspace Overview"
                color: Appearance.m3colors.m3onSurface
                font.family: Appearance.font.family
                font.pixelSize: 20
                font.weight: Font.Bold
            }

            GridLayout {
                columns: 3
                columnSpacing: 16
                rowSpacing: 16
                Layout.fillWidth: true

                Repeater {
                    model: 9
                    delegate: MouseArea {
                        required property int index
                        implicitWidth: 230
                        implicitHeight: 120
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            WMInterface.switchWorkspace(index + 1);
                            GlobalStates.overviewOpen = false;
                        }

                        MaterialShape {
                            anchors.fill: parent
                            radius: Appearance.rounding.medium
                            color: (index + 1) === WMInterface.activeWorkspace ? Appearance.m3colors.m3primaryContainer : Appearance.m3colors.m3surfaceContainer

                            ColumnLayout {
                                anchors.centerIn: parent
                                spacing: 8

                                MaterialSymbol {
                                    icon: "dashboard"
                                    size: 28
                                    color: (index + 1) === WMInterface.activeWorkspace ? Appearance.m3colors.m3onPrimaryContainer : Appearance.m3colors.m3primary
                                    Layout.alignment: Qt.AlignHCenter
                                }

                                Text {
                                    text: "Tag " + (index + 1)
                                    color: (index + 1) === WMInterface.activeWorkspace ? Appearance.m3colors.m3onPrimaryContainer : Appearance.m3colors.m3onSurface
                                    font.family: Appearance.font.family
                                    font.pixelSize: 14
                                    font.weight: Font.Bold
                                    Layout.alignment: Qt.AlignHCenter
                                }
                            }
                        }
                    }
                }
            }

            Item { Layout.fillHeight: true }
        }
    }
}
