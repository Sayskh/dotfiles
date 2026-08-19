import QtQuick
import Quickshell
import Quickshell.Wayland
import "../common"

PanelWindow {
    id: root

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    color: "transparent"
    mask: Region {} // Let all clicks pass through

    readonly property real radius: Appearance.rounding.large

    // Top-Left Corner
    Canvas {
        anchors.top: parent.top
        anchors.left: parent.left
        width: root.radius
        height: root.radius
        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            ctx.fillStyle = Appearance.colors.background;
            ctx.beginPath();
            ctx.moveTo(0, 0);
            ctx.lineTo(root.radius, 0);
            ctx.arc(root.radius, root.radius, root.radius, 1.5 * Math.PI, Math.PI, true);
            ctx.lineTo(0, root.radius);
            ctx.closePath();
            ctx.fill();
        }
    }

    // Top-Right Corner
    Canvas {
        anchors.top: parent.top
        anchors.right: parent.right
        width: root.radius
        height: root.radius
        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            ctx.fillStyle = Appearance.colors.background;
            ctx.beginPath();
            ctx.moveTo(root.radius, 0);
            ctx.lineTo(0, 0);
            ctx.arc(0, root.radius, root.radius, 1.5 * Math.PI, 0, false);
            ctx.lineTo(root.radius, root.radius);
            ctx.closePath();
            ctx.fill();
        }
    }

    // Bottom-Left Corner
    Canvas {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: root.radius
        height: root.radius
        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            ctx.fillStyle = Appearance.colors.background;
            ctx.beginPath();
            ctx.moveTo(0, root.radius);
            ctx.lineTo(root.radius, root.radius);
            ctx.arc(root.radius, 0, root.radius, 0.5 * Math.PI, Math.PI, false);
            ctx.lineTo(0, 0);
            ctx.closePath();
            ctx.fill();
        }
    }

    // Bottom-Right Corner
    Canvas {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: root.radius
        height: root.radius
        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            ctx.fillStyle = Appearance.colors.background;
            ctx.beginPath();
            ctx.moveTo(root.radius, root.radius);
            ctx.lineTo(0, root.radius);
            ctx.arc(0, 0, root.radius, 0.5 * Math.PI, 0, true);
            ctx.lineTo(root.radius, 0);
            ctx.closePath();
            ctx.fill();
        }
    }
}
