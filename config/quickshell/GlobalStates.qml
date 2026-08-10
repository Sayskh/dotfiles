import QtQuick
import Quickshell

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
    property bool screenLocked: false

    // Helper to toggle panel states
    function toggleSearch() { searchOpen = !searchOpen; }
    function toggleSidebarRight() { sidebarRightOpen = !sidebarRightOpen; }
    function toggleSidebarLeft() { sidebarLeftOpen = !sidebarLeftOpen; }
    function toggleMediaControls() { mediaControlsOpen = !mediaControlsOpen; }
    function toggleSettings() { settingsOpen = !settingsOpen; }
}
