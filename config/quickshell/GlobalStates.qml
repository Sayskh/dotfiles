import QtQuick
import Quickshell
import "services"

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root

    property bool barOpen: true
    property bool crosshairOpen: false
    property bool sidebarLeftOpen: false
    property bool sidebarRightOpen: false
    property bool mediaControlsOpen: false
    property bool osdBrightnessOpen: false
    property bool settingsOpen: false
    property bool osdVolumeOpen: false
    property bool oskOpen: false
    property bool overlayOpen: false
    property bool overviewOpen: false
    property bool regionSelectorOpen: false
    property bool searchOpen: false
    property bool cheatsheetOpen: false
    property bool screenLocked: false
    property bool screenLockContainsCharacters: false
    property bool screenUnlockFailed: false
    property bool screenTranslatorOpen: false
    property bool sessionOpen: false
    property bool superDown: false
    property bool superReleaseMightTrigger: true
    property bool wallpaperSelectorOpen: false
    property bool workspaceShowNumbers: false
    property string settingsPage: ""
    property Item currentPageInstance: null
    property list<real> visualizerPoints: []
    property bool desktopWidgetKeyboardFocus: false
    property bool desktopMenuOpen: false
    property var desktopMenuScreen: null
    property real desktopMenuX: 0
    property real desktopMenuY: 0
    property string wallpaperSelectorTarget: "wallpaper"
    property bool dropShelfOpen: false
    property real dropShelfX: 0
    property real dropShelfY: 0

    onSidebarRightOpenChanged: {
        if (root.sidebarRightOpen) {
            Notifications.timeoutAll();
            Notifications.markAllRead();
        }
    }

    // Helper to toggle panel states
    function toggleSearch() { searchOpen = !searchOpen; }
    function toggleCheatsheet() { cheatsheetOpen = !cheatsheetOpen; }
    function toggleSidebarRight() { sidebarRightOpen = !sidebarRightOpen; }
    function toggleSidebarLeft() { sidebarLeftOpen = !sidebarLeftOpen; }
    function toggleMediaControls() { mediaControlsOpen = !mediaControlsOpen; }
    function toggleSettings() { settingsOpen = !settingsOpen; }
    function toggleWallpaperSelector() { wallpaperSelectorOpen = !wallpaperSelectorOpen; }
    function toggleSession() { sessionOpen = !sessionOpen; }
}
