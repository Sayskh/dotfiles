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

    signal brightnessChanged()

    Process {
        id: getProc
        command: ["sh", "-c", "brightnessctl g; brightnessctl m"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                if (data.trim().length > 0) {
                    if (root.rawCurrent === 80) {
                        root.rawCurrent = parseInt(data.trim()) || 80;
                    } else {
                        root.rawMax = parseInt(data.trim()) || 100;
                        if (root.rawMax > 0) {
                            root.brightness = root.rawCurrent / root.rawMax;
                        }
                    }
                }
            }
        }
    }

    Process { id: setProc }
    Process { id: nightLightProc }

    function setBrightness(val: real) {
        let clamped = Math.max(0.01, Math.min(1.0, val));
        root.brightness = clamped;
        let percent = Math.floor(clamped * 100);
        Quickshell.execDetached(["brightnessctl", "s", percent + "%", "--quiet"]);
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
