import QtQuick
import Quickshell
import Quickshell.Services.Notifications

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root

    component NotifItem : QtObject {
        required property int notificationId
        property Notification notification
        property string appName: notification?.appName ?? "System"
        property string appIcon: notification?.appIcon ?? "notifications"
        property string summary: notification?.summary ?? ""
        property string body: notification?.body ?? ""
        property double time: Date.now()
        property bool popup: true
    }

    property list<NotifItem> list: []
    property var popupList: list.filter(n => n.popup)
    property int unread: popupList.length

    signal notify(notif: var)

    NotificationServer {
        id: server

        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyMarkupSupported: true
        bodySupported: true
        imageSupported: true

        onNotification: (n) => {
            n.tracked = true;
            let item = notifComp.createObject(root, {
                notificationId: n.id,
                notification: n,
                time: Date.now(),
                popup: true
            });
            root.list = [...root.list, item];
            root.notify(item);
        }
    }

    Component {
        id: notifComp
        NotifItem {}
    }

    function dismiss(id: int) {
        let idx = root.list.findIndex(n => n.notificationId === id);
        if (idx !== -1) {
            let item = root.list[idx];
            if (item.notification) item.notification.dismiss();
            root.list.splice(idx, 1);
            root.list = root.list.slice(0);
        }
    }

    function clearAll() {
        root.list.forEach(n => { if (n.notification) n.notification.dismiss(); });
        root.list = [];
    }
}
