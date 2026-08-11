pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import "../modules/common"

Singleton {
    id: root

    property string time: ""
    property string date: ""
    property string dayOfWeek: ""
    property string timeZone: "Local"

    property list<var> worldClocks: [
        { city: "Tokyo", tz: "Asia/Tokyo", time: "" },
        { city: "London", tz: "Europe/London", time: "" },
        { city: "New York", tz: "America/New_York", time: "" }
    ]

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            const now = new Date();
            root.time = Qt.formatDateTime(now, "hh:mm");
            root.date = Qt.formatDateTime(now, "yyyy-MM-dd");
            root.dayOfWeek = Qt.formatDateTime(now, "dddd");
        }
    }
}
