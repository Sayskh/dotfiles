pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import "../modules/common"

Singleton {
    id: root

    property bool inhibitorActive: false

    function toggleInhibitor() {
        root.inhibitorActive = !root.inhibitorActive;
        if (root.inhibitorActive) {
            Quickshell.execDetached(["systemd-inhibit", "--what=idle", "--who=quickshell", "--why=user-toggle", "sleep", "infinity"]);
        } else {
            Quickshell.execDetached(["pkill", "-f", "systemd-inhibit --what=idle"]);
        }
    }
}
