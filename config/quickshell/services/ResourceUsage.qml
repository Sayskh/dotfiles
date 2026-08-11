pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import "../modules/common"

Singleton {
    id: root

    property list<real> cpuHistory: [0.1, 0.2, 0.15, 0.3, 0.25, 0.4, 0.2, 0.15, 0.3, 0.2]
    property list<real> ramHistory: [0.35, 0.36, 0.37, 0.38, 0.40, 0.41, 0.40, 0.42, 0.40, 0.41]
}
