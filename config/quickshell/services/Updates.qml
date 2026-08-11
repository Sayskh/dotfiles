pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import "../modules/common"

Singleton {
    id: root

    property int availableUpdates: 0
    property string lastChecked: "Never"
    property bool isChecking: false

    Process {
        id: updateProc
        command: ["sh", "-c", "nix flake check --dry-run 2>/dev/null | wc -l"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                root.availableUpdates = parseInt(data.trim()) || 0;
                root.lastChecked = Qt.formatDateTime(new Date(), "hh:mm");
                root.isChecking = false;
            }
        }
    }

    function checkForUpdates() {
        root.isChecking = true;
        updateProc.running = true;
    }
}
