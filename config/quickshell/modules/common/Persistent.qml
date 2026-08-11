pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string filePath: Directories.persistentStatePath
    property var state: ({})
    property bool ready: false

    function get(key: string, defaultValue: var): var {
        if (root.state && root.state.hasOwnProperty(key)) {
            return root.state[key];
        }
        return defaultValue;
    }

    function set(key: string, value: var) {
        let newState = Object.assign({}, root.state);
        newState[key] = value;
        root.state = newState;
        saveTimer.restart();
    }

    Timer {
        id: saveTimer
        interval: 100
        repeat: false
        onTriggered: {
            persistentFileView.setText(JSON.stringify(root.state, null, 2));
        }
    }

    FileView {
        id: persistentFileView
        path: root.filePath
        watchChanges: true
        onLoaded: {
            try {
                root.state = JSON.parse(persistentFileView.text());
            } catch (e) {
                root.state = {};
            }
            root.ready = true;
        }
        onLoadFailed: error => {
            root.state = {};
            persistentFileView.setText("{}");
            root.ready = true;
        }
    }
}
