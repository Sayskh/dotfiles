import QtQuick
import QtQuick.Layouts
import "../../common"
import "../../../services"

Item {
    id: root
    width: 140
    height: 140

    readonly property date now: new Date()
    readonly property int hours: now.getHours()
    readonly property int minutes: now.getMinutes()
    readonly property int seconds: now.getSeconds()

    // Scalloped / Petal-shaped M3 Background
    Canvas {
        id: petalCanvas
        anchors.fill: parent
        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();
            const cx = width / 2;
            const cy = height / 2;
            const outerR = width / 2 - 4;
            const innerR = outerR - 12;
            const petals = 12;

            ctx.fillStyle = Appearance.colors.primaryContainer;
            ctx.beginPath();
            for (let i = 0; i < petals * 2; i++) {
                const angle = (i * Math.PI) / petals;
                const r = (i % 2 === 0) ? outerR : innerR;
                const x = cx + Math.cos(angle) * r;
                const y = cy + Math.sin(angle) * r;
                if (i === 0) ctx.moveTo(x, y);
                else ctx.lineTo(x, y);
            }
            ctx.closePath();
            ctx.fill();
        }
    }

    // Numbers (12, 3, 6, 9)
    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 12
        text: "12"
        font.family: Appearance.font.family
        font.pixelSize: 18
        font.weight: Font.Bold
        color: Appearance.colors.onPrimaryContainer
        opacity: 0.35
    }

    Text {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 14
        text: "3"
        font.family: Appearance.font.family
        font.pixelSize: 18
        font.weight: Font.Bold
        color: Appearance.colors.onPrimaryContainer
        opacity: 0.35
    }

    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 12
        text: "6"
        font.family: Appearance.font.family
        font.pixelSize: 18
        font.weight: Font.Bold
        color: Appearance.colors.onPrimaryContainer
        opacity: 0.35
    }

    Text {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 14
        text: "9"
        font.family: Appearance.font.family
        font.pixelSize: 18
        font.weight: Font.Bold
        color: Appearance.colors.onPrimaryContainer
        opacity: 0.35
    }

    // Hour Hand
    Rectangle {
        id: hourHand
        width: 6
        height: 38
        radius: 3
        color: Appearance.colors.onPrimaryContainer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        transformOrigin: Item.Bottom
        rotation: (root.hours % 12 + root.minutes / 60) * 30
        Behavior on rotation { NumberAnimation { duration: 250 } }
    }

    // Minute Hand
    Rectangle {
        id: minuteHand
        width: 4
        height: 52
        radius: 2
        color: Appearance.colors.primary
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        transformOrigin: Item.Bottom
        rotation: (root.minutes + root.seconds / 60) * 6
        Behavior on rotation { NumberAnimation { duration: 250 } }
    }

    // Center Pin
    Rectangle {
        width: 10
        height: 10
        radius: 5
        color: Appearance.colors.onPrimaryContainer
        anchors.centerIn: parent
    }

    // Digital numbers badge overlay (top-left & bottom-right as in screenshot)
    Text {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: -12
        anchors.topMargin: 22
        text: root.hours.toString().padStart(2, '0')
        font.family: Appearance.font.family
        font.pixelSize: 20
        font.weight: Font.Black
        color: Appearance.colors.onSurface
    }

    Text {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: -12
        anchors.bottomMargin: 22
        text: root.minutes.toString().padStart(2, '0')
        font.family: Appearance.font.family
        font.pixelSize: 20
        font.weight: Font.Black
        color: Appearance.colors.onSurface
    }
}
