pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import "../modules/common"

Singleton {
    id: root

    property string location: "Jakarta"
    property string temp: "28°C"
    property string condition: "Partly Cloudy"
    property string icon: "partly_cloudy_day"
    property string humidity: "75%"
    property string wind: "12 km/h"

    Process {
        id: weatherProc
        command: ["curl", "-s", "wttr.in/?format=%t+%C+%h+%w"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const parts = data.trim().split(" ");
                if (parts.length >= 2) {
                    root.temp = parts[0];
                    root.condition = parts.slice(1).join(" ");
                }
            }
        }
    }

    Timer {
        interval: 1800000 // 30 minutes
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: weatherProc.running = true
    }
}
