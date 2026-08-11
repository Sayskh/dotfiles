pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick

Singleton {
    id: root

    readonly property var iconMap: ({
        "search": "search",
        "settings": "settings",
        "home": "home",
        "folder": "folder",
        "lock": "lock",
        "power": "power_settings_new",
        "restart": "restart_alt",
        "logout": "logout",
        "volume_high": "volume_up",
        "volume_medium": "volume_down",
        "volume_low": "volume_mute",
        "volume_off": "volume_off",
        "mic": "mic",
        "mic_off": "mic_off",
        "brightness": "brightness_6",
        "wifi": "wifi",
        "wifi_off": "wifi_off",
        "bluetooth": "bluetooth",
        "bluetooth_off": "bluetooth_disabled",
        "battery": "battery_full",
        "notifications": "notifications",
        "notifications_off": "notifications_off",
        "play": "play_arrow",
        "pause": "pause",
        "skip_next": "skip_next",
        "skip_previous": "skip_previous",
        "wallpaper": "image",
        "calendar": "calendar_today",
        "clock": "schedule",
        "edit": "edit",
        "delete": "delete",
        "add": "add",
        "check": "check",
        "close": "close",
        "chevron_right": "chevron_right",
        "chevron_left": "chevron_left",
        "expand_more": "expand_more",
        "expand_less": "expand_less",
        "info": "info",
        "warning": "warning",
        "error": "error"
    })

    function getIcon(name: string): string {
        return iconMap[name] || name || "help_outline";
    }
}
