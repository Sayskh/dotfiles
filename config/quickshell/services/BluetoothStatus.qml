import QtQuick
import Quickshell
import Quickshell.Io

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root

    property bool enabled: true
    property bool connected: false
    property string connectedDevice: ""

    Process {
        id: btProc
        command: ["bluetoothctl", "show"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                if (data.includes("Powered: yes")) {
                    root.enabled = true;
                } else if (data.includes("Powered: no")) {
                    root.enabled = false;
                }
            }
        }
    }

    Timer {
        interval: 10000
        repeat: true
        running: true
        onTriggered: btProc.running = true
    }

    Component.onCompleted: {
        btProc.running = true;
    }
}
