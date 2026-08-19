pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import "../modules/common"

Singleton {
    id: root

    property real brightness: 0.8
    property int rawMax: 100
    property int rawCurrent: 80
    property bool nightLightActive: false
    property int nightLightTemp: 4000
    property real kbdBrightness: 0.5
    property bool isExternalMonitor: false

    signal brightnessChanged()

    // Query brightnessctl first; if failed, check ddcutil for external monitors
    Process {
        id: getProc
        command: ["sh", "-c", "brightnessctl g 2>/dev/null; brightnessctl m 2>/dev/null"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const trimmed = data.trim();
                if (trimmed.length > 0) {
                    if (root.rawCurrent === 80) {
                        root.rawCurrent = parseInt(trimmed) || 80;
                    } else {
                        root.rawMax = parseInt(trimmed) || 100;
                        if (root.rawMax > 0) {
                            root.brightness = root.rawCurrent / root.rawMax;
                        }
                    }
                }
            }
        }
        onExited: {
            if (root.rawMax <= 0 || isNaN(root.brightness)) {
                root.isExternalMonitor = true;
                ddcGetProc.running = true;
            }
        }
    }

    // DDC/CI fallback for external desktop monitors
    Process {
        id: ddcGetProc
        command: ["sh", "-c", "ddcutil getvcp 10 --terse 2>/dev/null | awk '{print $4, $5}'"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const parts = data.trim().split(/\s+/);
                if (parts.length >= 2) {
                    const cur = parseInt(parts[0]);
                    const max = parseInt(parts[1]);
                    if (!isNaN(cur) && !isNaN(max) && max > 0) {
                        root.rawCurrent = cur;
                        root.rawMax = max;
                        root.brightness = cur / max;
                    }
                }
            }
        }
    }

    function setBrightness(val: real) {
        let clamped = Math.max(0.01, Math.min(1.0, val));
        root.brightness = clamped;
        let percent = Math.floor(clamped * 100);

        if (root.isExternalMonitor) {
            Quickshell.execDetached(["ddcutil", "setvcp", "10", percent.toString()]);
        } else {
            Quickshell.execDetached(["brightnessctl", "s", percent + "%", "--quiet"]);
        }
        root.brightnessChanged();
    }

    function increaseBrightness(step: real = 0.05) {
        setBrightness(root.brightness + step);
    }

    function decreaseBrightness(step: real = 0.05) {
        setBrightness(root.brightness - step);
    }

    function toggleNightLight() {
        root.nightLightActive = !root.nightLightActive;
        if (root.nightLightActive) {
            Quickshell.execDetached(["wlsunset", "-t", root.nightLightTemp.toString(), "-T", "6500"]);
        } else {
            Quickshell.execDetached(["pkill", "-f", "wlsunset"]);
        }
    }

    function setKbdBrightness(val: real) {
        let clamped = Math.max(0.0, Math.min(1.0, val));
        root.kbdBrightness = clamped;
        let percent = Math.floor(clamped * 100);
        Quickshell.execDetached(["brightnessctl", "-d", "*:kbd_backlight", "s", percent + "%"]);
    }

    Component.onCompleted: {
        getProc.running = true;
    }
}
