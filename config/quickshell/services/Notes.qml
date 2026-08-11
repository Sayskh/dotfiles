pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import "../modules/common"

Singleton {
    id: root

    property string filePath: Directories.notesPath
    property string text: ""
    property bool ready: false

    function saveText(newText: string) {
        root.text = newText;
        notesFileView.setText(newText);
    }

    FileView {
        id: notesFileView
        path: root.filePath
        watchChanges: true
        onLoaded: {
            root.text = notesFileView.text();
            root.ready = true;
        }
        onLoadFailed: error => {
            if (error === FileViewError.FileNotFound) {
                root.text = "# Quick Notes\n\nWrite your thoughts here...";
                notesFileView.setText(root.text);
            }
            root.ready = true;
        }
    }
}
