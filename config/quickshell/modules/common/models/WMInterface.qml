pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    // Active workspace/tag (1-9)
    property int activeWorkspace: 1
    property int totalWorkspaces: 9

    // Workspace state map
    property var activeTags: [true, false, false, false, false, false, false, false, false]
    property var occupiedTags: [true, false, false, false, false, false, false, false, false]
    property var monitorWorkspaces: ({})

    // Active window info
    property string activeWindowTitle: "MangoWC Desktop"
    property string activeWindowClass: ""

    // ── Live MangoWC IPC Event Stream (mmsg -w -t) ──
    Process {
        id: mangoEvents
        command: ["mmsg", "-w", "-t"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                refreshTagsProc.running = true;
            }
        }
    }

    // ── Parse mmsg -g -t output for real tag state ──
    Process {
        id: refreshTagsProc
        command: ["mmsg", "-g", "-t"]
        property string buf: ""

        stdout: SplitParser {
            onRead: data => {
                refreshTagsProc.buf += data;
            }
        }

        onExited: {
            try {
                const lines = refreshTagsProc.buf.trim().split("\n");
                const newActive = [false, false, false, false, false, false, false, false, false];
                const newOccupied = [false, false, false, false, false, false, false, false, false];

                for (let i = 0; i < lines.length; i++) {
                    const line = lines[i].trim();
                    if (!line) continue;
                    const parts = line.split(/\s+/);
                    if (parts.length >= 6 && parts[1] === "tag") {
                        const tagNum = parseInt(parts[2]);
                        const state = parseInt(parts[3]);
                        const clients = parseInt(parts[4]);
                        const focused = parseInt(parts[5]);

                        if (tagNum >= 1 && tagNum <= root.totalWorkspaces) {
                            const idx = tagNum - 1;
                            if (clients > 0) newOccupied[idx] = true;
                            if (focused === 1 || state === 1) {
                                newActive[idx] = true;
                                root.activeWorkspace = tagNum;
                            }
                        }
                    }
                }

                root.activeTags = newActive;
                root.occupiedTags = newOccupied;
            } catch (e) {
                console.log("[WMInterface] Tag parse error: " + e);
            }
            refreshTagsProc.buf = "";
        }
    }

    // ── Command Execution ──
    Process {
        id: execProc
    }

    function runCmd(cmd: string) {
        execProc.command = ["sh", "-c", cmd];
        execProc.running = true;
    }

    // Switch active workspace (tag) via mmsg or wtype fallback
    function switchWorkspace(tagIndex: int) {
        if (tagIndex < 1 || tagIndex > totalWorkspaces) return;
        activeWorkspace = tagIndex;

        const newTags = [];
        for (let i = 0; i < totalWorkspaces; i++) {
            newTags.push(i === (tagIndex - 1));
        }
        activeTags = newTags;

        // Use native MangoWC IPC command
        Quickshell.execDetached(["mmsg", "-s", "-t", tagIndex.toString()], (proc) => {
            // If mmsg fails, fallback to wtype
            if (proc.exitCode !== 0) {
                runCmd("wtype -M super -k " + tagIndex);
            }
        });
    }

    function toggleFloating() {
        runCmd("wtype -M super -M shift -k space");
    }

    function closeActiveWindow() {
        runCmd("wtype -M super -M shift -k c");
    }

    function launchApp(command: string) {
        runCmd(command + " &");
    }

    Component.onCompleted: {
        refreshTagsProc.running = true;
    }
}
