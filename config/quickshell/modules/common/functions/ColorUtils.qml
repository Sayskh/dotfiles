import QtQuick
import Quickshell

pragma Singleton

Singleton {
    id: root

    function colorWithHueOf(color1, color2) {
        var c1 = Qt.color(color1);
        var c2 = Qt.color(color2);
        return Qt.hsva(c2.hsvHue, c1.hsvSaturation, c1.hsvValue, c1.a);
    }

    function colorWithSaturationOf(color1, color2) {
        var c1 = Qt.color(color1);
        var c2 = Qt.color(color2);
        return Qt.hsva(c1.hsvHue, c2.hsvSaturation, c1.hsvValue, c1.a);
    }

    function colorWithLightness(color, lightness) {
        var c = Qt.color(color);
        return Qt.hsla(c.hslHue, c.hslSaturation, lightness, c.a);
    }

    function colorWithLightnessOf(color1, color2) {
        var c2 = Qt.color(color2);
        return colorWithLightness(color1, c2.hslLightness);
    }

    function adaptToAccent(color1, color2) {
        var c1 = Qt.color(color1);
        var c2 = Qt.color(color2);
        return Qt.hsla(c2.hslHue, c2.hslSaturation, c1.hslLightness, c1.a);
    }

    function mix(color1, color2, percentage = 0.5) {
        var c1 = Qt.color(color1);
        var c2 = Qt.color(color2);
        return Qt.rgba(percentage * c1.r + (1 - percentage) * c2.r, percentage * c1.g + (1 - percentage) * c2.g, percentage * c1.b + (1 - percentage) * c2.b, percentage * c1.a + (1 - percentage) * c2.a);
    }

    function transparentize(color, percentage = 1) {
        var c = Qt.color(color);
        return Qt.rgba(c.r, c.g, c.b, c.a * (1 - percentage));
    }

    function applyAlpha(color, alpha) {
        var c = Qt.color(color);
        var a = Math.max(0, Math.min(1, alpha));
        return Qt.rgba(c.r, c.g, c.b, a);
    }

    function isDark(color) {
        var c = Qt.color(color);
        return c.hslLightness < 0.5;
    }

    function clamp01(x) {
        return Math.min(1, Math.max(0, x));
    }

    function solveOverlayColor(baseColor, targetColor, overlayOpacity) {
        const bc = Qt.color(baseColor);
        const tc = Qt.color(targetColor);
        if (overlayOpacity <= 0) return tc;
        let invA = 1.0 - overlayOpacity;

        let r = (tc.r - bc.r * invA) / overlayOpacity;
        let g = (tc.g - bc.g * invA) / overlayOpacity;
        let b = (tc.b - bc.b * invA) / overlayOpacity;

        return Qt.rgba(clamp01(r), clamp01(g), clamp01(b), overlayOpacity);
    }
}
