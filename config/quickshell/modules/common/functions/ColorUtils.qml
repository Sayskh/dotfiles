import QtQuick

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root

    // Mix two colors with a ratio (0.0 to 1.0)
    function mix(color1: color, color2: color, weight: real): color {
        let w = Math.max(0, Math.min(1, weight));
        let r = color1.r * (1 - w) + color2.r * w;
        let g = color1.g * (1 - w) + color2.g * w;
        let b = color1.b * (1 - w) + color2.b * w;
        let a = color1.a * (1 - w) + color2.a * w;
        return Qt.rgba(r, g, b, a);
    }

    // Adjust opacity
    function transparentize(col: color, alpha: real): color {
        return Qt.rgba(col.r, col.g, col.b, alpha);
    }

    // Lighten color
    function lighten(col: color, factor: real): color {
        return mix(col, Qt.rgba(1, 1, 1, col.a), factor);
    }

    // Darken color
    function darken(col: color, factor: real): color {
        return mix(col, Qt.rgba(0, 0, 0, col.a), factor);
    }

    // Calculate relative luminance for contrast checking
    function luminance(col: color): real {
        let a = [col.r, col.g, col.b].map(function (v) {
            return v <= 0.03928 ? v / 12.92 : Math.pow((v + 0.055) / 1.055, 2.4);
        });
        return a[0] * 0.2126 + a[1] * 0.7152 + a[2] * 0.0722;
    }

    // Returns true if color is dark
    function isDark(col: color): bool {
        return luminance(col) < 0.5;
    }
}
