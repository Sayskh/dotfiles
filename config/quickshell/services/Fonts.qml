pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import "../modules/common"

Singleton {
    id: root

    readonly property string iconFontFamily: materialSymbolsLoader.name
    readonly property string sansFontFamily: interLoader.name

    FontLoader {
        id: materialSymbolsLoader
        source: Directories.assetsPath + "/fonts/MaterialSymbolsRounded.ttf"
    }

    FontLoader {
        id: interLoader
        source: Directories.assetsPath + "/fonts/Inter.ttf"
    }
}
