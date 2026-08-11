import QtQuick
import Quickshell
import Quickshell.Io

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root

    property real brightness: 0.8
    property int rawMax: 100
    property int rawCurrent: 80

    signal brightnessChanged()

    Process {
        id: getProc
        command: ["sh", "-c", "brightnessctl g; brightnessctl m"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                if (data.trim().length > 0) {
                    if (root.rawCurrent === 80) {
                        root.rawCurrent = parseInt(data.trim());
                    } else {
                        root.rawMax = parseInt(data.trim());
                        if (root.rawMax > 0) {
                            root.brightness = root.rawCurrent / root.rawMax;
                        }
                    }
                }
            }
        }
    }

    Process {
        id: setProc
    }

    function setBrightness(val: real) {
        let clamped = Math.max(0.01, Math.min(1.0, val));
        root.brightness = clamped;
        let percent = Math.floor(clamped * 100);
        setProc.exec(["brightnessctl", "s", percent + "%", "--quiet"]);
        root.brightnessChanged();
    }

    function increaseBrightness(step: real = 0.05) {
        setBrightness(root.brightness + step);
    }

    function decreaseBrightness(step: real = 0.05) {
        setBrightness(root.brightness - step);
    }

    Component.onCompleted: {
        getProc.running = true;
    }
}
