pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import "../modules/common"

Singleton {
    id: root

    property int secondsRemaining: 0
    property bool running: false
    property string formattedTime: formatTime(secondsRemaining)

    signal timerFinished()

    Timer {
        id: internalTimer
        interval: 1000
        repeat: true
        running: root.running
        onTriggered: {
            if (root.secondsRemaining > 0) {
                root.secondsRemaining--;
            } else {
                root.running = false;
                root.timerFinished();
            }
        }
    }

    function startTimer(seconds: int) {
        root.secondsRemaining = seconds;
        root.running = true;
    }

    function stopTimer() {
        root.running = false;
    }

    function resetTimer() {
        root.running = false;
        root.secondsRemaining = 0;
    }

    function formatTime(secs: int): string {
        const m = Math.floor(secs / 60);
        const s = secs % 60;
        return `${m}:${s < 10 ? '0' : ''}${s}`;
    }
}
