pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import "../modules/common"

Singleton {
    id: root

    property bool enabled: true
    property bool connected: false
    property string connectedDevice: ""
    property list<var> devices: []
    property list<var> connectedDevices: []

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

    Process {
        id: devProc
        command: ["bluetoothctl", "devices"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const line = data.trim();
                if (!line) return;
                const parts = line.split(" ");
                if (parts.length >= 3) {
                    const mac = parts[1];
                    const name = parts.slice(2).join(" ");
                    if (mac && !root.devices.some(d => d.mac === mac)) {
                        root.devices.push({ mac: mac, name: name, connected: false });
                    }
                }
            }
        }
    }

    function toggleBluetooth() {
        root.enabled = !root.enabled;
        const cmd = root.enabled ? "power on" : "power off";
        Quickshell.execDetached(["bluetoothctl", cmd]);
    }

    function connectDevice(mac: string) {
        Quickshell.execDetached(["bluetoothctl", "connect", mac]);
    }

    function disconnectDevice(mac: string) {
        Quickshell.execDetached(["bluetoothctl", "disconnect", mac]);
    }

    function scanDevices() {
        root.devices = [];
        devProc.running = true;
    }

    Timer {
        interval: 10000
        repeat: true
        running: true
        onTriggered: {
            btProc.running = true;
            scanDevices();
        }
    }

    Component.onCompleted: {
        btProc.running = true;
        scanDevices();
    }
}
