import QtQuick
import Quickshell
import Quickshell.Io

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root

    // Active workspace/tag (1-9)
    property int activeWorkspace: 1
    property int totalWorkspaces: 9

    // Workspace state map (bitmask or array of tags)
    property var activeTags: [true, false, false, false, false, false, false, false, false]
    property var occupiedTags: [true, false, false, false, false, false, false, false, false]

    // Active window info
    property string activeWindowTitle: "MangoWC Desktop"
    property string activeWindowClass: ""

    // ── Command Execution for MangoWC ──
    Process {
        id: execProc
    }

    function runCmd(cmd: string) {
        execProc.command = ["sh", "-c", cmd];
        execProc.running = true;
    }

    // Switch active workspace (tag)
    function switchWorkspace(tagIndex: int) {
        if (tagIndex < 1 || tagIndex > totalWorkspaces) return;
        activeWorkspace = tagIndex;
        
        // Update tags list
        let newTags = [];
        for (let i = 0; i < totalWorkspaces; i++) {
            newTags.push(i === (tagIndex - 1));
        }
        activeTags = newTags;

        // Command to switch tag in MangoWC via IPC / wtype or mangowc IPC tool if available
        runCmd("wtype -M super -k " + tagIndex);
    }

    // Toggle window floating
    function toggleFloating() {
        runCmd("wtype -M super -M shift -k space");
    }

    // Close focused window
    function closeActiveWindow() {
        runCmd("wtype -M super -M shift -k c");
    }

    // Spawn app launcher
    function launchApp(command: string) {
        runCmd(command + " &");
    }
}
