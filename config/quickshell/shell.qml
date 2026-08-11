import QtQuick
import Quickshell

import "modules/common"
import "modules/common/widgets"
import "modules/common/models"
import "modules/bar"
import "modules/dock"
import "modules/search"
import "modules/sidebarRight"
import "modules/sidebarLeft"
import "modules/mediaControls"
import "modules/wallpaperSelector"
import "modules/lock"
import "modules/overview"
import "modules/osd"
import "modules/notifications"
import "modules/cheatsheet"
import "services"

ShellRoot {
    id: root

    Bar {}
    Dock {}
    SearchOverlay {}
    SidebarRight {}
    SidebarLeft {}
    MediaControlsOverlay {}
    WallpaperSelectorOverlay {}
    LockScreen {}
    OverviewOverlay {}
    OSD {}
    NotificationPopup {}
    CheatsheetOverlay {}
}
