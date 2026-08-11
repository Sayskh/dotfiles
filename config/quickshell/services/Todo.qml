pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import "../modules/common"

Singleton {
    id: root

    property string filePath: Directories.todoPath
    property list<var> items: []
    property bool ready: false

    function addItem(text: string) {
        if (!text || text.trim() === "") return;
        const newItem = {
            id: Date.now(),
            text: text.trim(),
            done: false,
            time: Date.now()
        };
        root.items = [...root.items, newItem];
        save();
    }

    function toggleItem(id: var) {
        root.items = root.items.map(item => {
            if (item.id === id) item.done = !item.done;
            return item;
        });
        save();
    }

    function removeItem(id: var) {
        root.items = root.items.filter(item => item.id !== id);
        save();
    }

    function save() {
        todoFileView.setText(JSON.stringify(root.items, null, 2));
    }

    FileView {
        id: todoFileView
        path: root.filePath
        watchChanges: true
        onLoaded: {
            try {
                root.items = JSON.parse(todoFileView.text());
            } catch (e) {
                root.items = [];
            }
            root.ready = true;
        }
        onLoadFailed: error => {
            if (error === FileViewError.FileNotFound) {
                root.items = [
                    { id: 1, text: "Install NixOS dotfiles", done: true, time: Date.now() },
                    { id: 2, text: "Try out Quickshell desktop", done: false, time: Date.now() }
                ];
                save();
            }
            root.ready = true;
        }
    }
}
