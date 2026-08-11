pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick

Singleton {
    id: root

    function trimFileProtocol(path: string): string {
        if (!path) return "";
        if (path.startsWith("file://")) {
            return path.substring(7);
        }
        return path;
    }
}
