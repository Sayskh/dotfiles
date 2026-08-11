pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import "../modules/common"

Singleton {
    id: root

    property bool connected: false
    property bool wifiEnabled: true
    property bool ethernetConnected: false
    property bool vpnConnected: false
    property string vpnName: ""
    property string ssid: "Disconnected"
    property int signalStrength: 0
    property string ipAddress: ""
    property list<var> wifiNetworks: []

    Process {
        id: statusProc
        command: ["nmcli", "-t", "-f", "TYPE,STATE,CONNECTION", "dev"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const line = data.trim();
                if (line.includes("wifi:connected")) {
                    root.connected = true;
                } else if (line.includes("ethernet:connected")) {
                    root.ethernetConnected = true;
                    root.connected = true;
                }
            }
        }
    }

    Process {
        id: wifiScanProc
        command: ["nmcli", "-t", "-f", "IN-USE,SSID,SIGNAL,SECURITY", "dev", "wifi"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const line = data.trim();
                if (!line) return;
                const parts = line.split(":");
                if (parts.length >= 3) {
                    const active = parts[0] === "*";
                    const netSsid = parts[1];
                    const signal = parseInt(parts[2]) || 0;
                    const security = parts[3] || "Open";
                    if (netSsid && !root.wifiNetworks.some(n => n.ssid === netSsid)) {
                        root.wifiNetworks.push({
                            active: active,
                            ssid: netSsid,
                            signal: signal,
                            security: security
                        });
                    }
                    if (active) {
                        root.ssid = netSsid;
                        root.signalStrength = signal;
                    }
                }
            }
        }
    }

    function scanWifi() {
        root.wifiNetworks = [];
        wifiScanProc.running = true;
    }

    function toggleWifi() {
        root.wifiEnabled = !root.wifiEnabled;
        const cmd = root.wifiEnabled ? "on" : "off";
        Quickshell.execDetached(["nmcli", "radio", "wifi", cmd]);
    }

    function connectToNetwork(ssid: string, password: string = "") {
        if (password) {
            Quickshell.execDetached(["nmcli", "dev", "wifi", "connect", ssid, "password", password]);
        } else {
            Quickshell.execDetached(["nmcli", "dev", "wifi", "connect", ssid]);
        }
    }

    Timer {
        interval: 10000
        repeat: true
        running: true
        onTriggered: {
            statusProc.running = true;
            scanWifi();
        }
    }

    Component.onCompleted: {
        statusProc.running = true;
        scanWifi();
    }
}
