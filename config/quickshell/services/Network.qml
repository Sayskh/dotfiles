import QtQuick
import Quickshell
import Quickshell.Io

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root

    property bool connected: true
    property string ssid: "Wi-Fi Network"
    property string interfaceName: "wlan0"

    Process {
        id: netProc
        command: ["nmcli", "-t", "-f", "active,ssid", "dev", "wifi"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                let lines = data.split("\n");
                for (let line of lines) {
                    if (line.startsWith("yes:")) {
                        root.connected = true;
                        root.ssid = line.substring(4);
                        return;
                    }
                }
            }
        }
    }

    Timer {
        interval: 10000
        repeat: true
        running: true
        onTriggered: netProc.running = true
    }

    Component.onCompleted: {
        netProc.running = true;
    }
}
