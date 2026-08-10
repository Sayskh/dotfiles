import QtQuick
import Quickshell

import "modules/common"
import "modules/common/widgets"
import "modules/common/models"
import "modules/bar"
import "modules/dock"
import "modules/search"
import "modules/sidebarRight"
import "modules/osd"
import "modules/notifications"

ShellRoot {
    id: root

    Bar {}
    Dock {}
    SearchOverlay {}
    SidebarRight {}
    OSD {}
    NotificationPopup {}
}

