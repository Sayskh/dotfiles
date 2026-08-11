pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import "../modules/common"

Singleton {
    id: root

    property list<var> appList: []
    property bool isScanning: false

    Process {
        id: scanProc
        command: ["sh", "-c", "find /run/current-system/sw/share/applications ~/.nix-profile/share/applications /usr/share/applications -name '*.desktop' 2>/dev/null"]
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const path = data.trim();
                if (path.length > 0) {
                    parseDesktopFile(path);
                }
            }
        }
    }

    function parseDesktopFile(path: string) {
        Quickshell.execDetached(["sh", "-c", `grep -E '^(Name|Exec|Icon|NoDisplay)=' "${path}" | head -n 4`], (proc) => {
            // Callback placeholder
        });
    }

    function search(query: string): var {
        if (!query || query.trim() === "") return root.appList;
        const q = query.toLowerCase().trim();
        return root.appList.filter(app => {
            return (app.name && app.name.toLowerCase().includes(q)) ||
                   (app.exec && app.exec.toLowerCase().includes(q));
        });
    }

    function launch(execCmd: string) {
        if (!execCmd) return;
        const cleanCmd = execCmd.replace(/%[fFuUdDnNiImk]/g, "").trim();
        Quickshell.execDetached(["sh", "-c", cleanCmd]);
    }

    Component.onCompleted: {
        // Fallback default list while scan completes
        root.appList = [
            { name: "Firefox", exec: "firefox", icon: "firefox" },
            { name: "Terminal", exec: "foot", icon: "utilities-terminal" },
            { name: "File Manager", exec: "thunar", icon: "system-file-manager" },
            { name: "Code Editor", exec: "code", icon: "visual-studio-code" },
            { name: "Discord", exec: "discord", icon: "discord" },
            { name: "Spotify", exec: "spotify", icon: "spotify" },
            { name: "Settings", exec: "pavucontrol", icon: "preferences-system" }
        ];
        scanProc.running = true;
    }
}
