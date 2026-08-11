pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import "../modules/common"

Singleton {
    id: root

    property list<var> items: []

    Process {
        id: clipProc
        command: ["sh", "-c", "cliphist list | head -n 30"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const line = data.trim();
                if (!line) return;
                const tabIdx = line.indexOf("\t");
                if (tabIdx !== -1) {
                    const id = line.substring(0, tabIdx);
                    const text = line.substring(tabIdx + 1);
                    if (!root.items.some(i => i.id === id)) {
                        root.items.push({ id: id, text: text });
                    }
                }
            }
        }
    }

    function refresh() {
        root.items = [];
        clipProc.running = true;
    }

    function copyToClipboard(id: string) {
        Quickshell.execDetached(["sh", "-c", `cliphist decode ${id} | wl-copy`]);
    }

    function clear() {
        Quickshell.execDetached(["cliphist", "wipe"]);
        root.items = [];
    }

    Component.onCompleted: {
        refresh();
    }
}
