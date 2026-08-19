pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import "../modules/common"

Singleton {
    id: root

    property string username: Quickshell.env("USER") ?? "user"
    property string hostname: "nixbtw"
    property string kernel: ""
    property string gpuModel: "Detecting GPU..."
    property real cpuUsage: 0.15
    property real ramUsage: 0.40
    property string ramText: "6.4 GB / 16.0 GB"
    property real diskUsage: 0.30
    property string diskText: "120 GB / 400 GB"

    // Memory Usage Process
    Process {
        id: memProc
        command: ["sh", "-c", "free -m | awk 'NR==2{printf \"%.2f %d %d\", $3/$2, $3, $2}'"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const parts = data.trim().split(" ");
                if (parts.length >= 3) {
                    root.ramUsage = parseFloat(parts[0]) || 0;
                    const usedGb = (parseInt(parts[1]) / 1024).toFixed(1);
                    const totalGb = (parseInt(parts[2]) / 1024).toFixed(1);
                    root.ramText = `${usedGb} GB / ${totalGb} GB`;
                }
            }
        }
    }

    // GPU & Kernel Hardware Autodetector
    Process {
        id: hwProc
        command: ["sh", "-c", "uname -r; lspci | grep -iE 'vga|3d|display' | head -n1 | sed -E 's/.*: //; s/ \\(rev.*//'"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const line = data.trim();
                if (!line) return;
                if (!root.kernel) {
                    root.kernel = line;
                } else {
                    root.gpuModel = line || "Standard Display Controller";
                }
            }
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            memProc.running = true;
            if (!root.kernel || root.gpuModel === "Detecting GPU...") {
                hwProc.running = true;
            }
        }
    }

    Component.onCompleted: {
        hwProc.running = true;
    }
}
