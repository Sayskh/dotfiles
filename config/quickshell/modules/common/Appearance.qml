import QtQuick
import Quickshell

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root

    // ── Font Family ──
    property QtObject font: QtObject {
        property string family: "Inter"
        property string monospace: "JetBrainsMono Nerd Font"
        property string symbols: "Material Symbols Rounded"
    }

    // ── Rounding (Border Radius) ──
    property QtObject rounding: QtObject {
        property int full: 9999
        property int extraLarge: 28
        property int large: 16
        property int medium: 12
        property int small: 8
        property int extraSmall: 4
        property int none: 0
    }

    // ── Component Sizes ──
    property QtObject sizes: QtObject {
        property int barHeight: 44
        property int dockHeight: 64
        property int iconSize: 20
        property int iconSizeLarge: 24
        property int iconSizeSmall: 16
    }

    // ── Animation Tokens ──
    property QtObject animation: QtObject {
        property int fast: 150
        property int normal: 250
        property int slow: 400
        property int easingType: Easing.OutCubic
    }

    // ── Material Design 3 Palette Tokens ──
    property QtObject m3colors: QtObject {
        property bool darkmode: true

        # Dark Surfaces (M3 Elevation hierarchy)
        property color m3background: "#141313"
        property color m3onBackground: "#e6e1e1"
        property color m3surface: "#141313"
        property color m3surfaceDim: "#141313"
        property color m3surfaceBright: "#3a3939"
        property color m3surfaceContainerLowest: "#0f0e0e"
        property color m3surfaceContainerLow: "#1c1b1c"
        property color m3surfaceContainer: "#201f20"
        property color m3surfaceContainerHigh: "#2b2a2a"
        property color m3surfaceContainerHighest: "#363435"
        property color m3onSurface: "#e6e1e1"
        property color m3surfaceVariant: "#49464a"
        property color m3onSurfaceVariant: "#cbc5ca"

        # Primary Accents
        property color m3primary: "#cbc4cb"
        property color m3onPrimary: "#322f34"
        property color m3primaryContainer: "#2d2a2f"
        property color m3onPrimaryContainer: "#bcb6bc"
        property color m3inversePrimary: "#615d63"

        # Secondary & Tertiary
        property color m3secondary: "#cac5c8"
        property color m3onSecondary: "#322f32"
        property color m3secondaryContainer: "#484548"
        property color m3onSecondaryContainer: "#e6e1e5"

        property color m3tertiary: "#d3c2c8"
        property color m3onTertiary: "#382d32"
        property color m3tertiaryContainer: "#504348"
        property color m3onTertiaryContainer: "#efdee4"

        # Outlines & Shadows
        property color m3outline: "#948f94"
        property color m3outlineVariant: "#49464a"
        property color m3shadow: "#000000"
        property color m3scrim: "#000000"
    }

    // Convenient aliases
    property color colLayer0: m3colors.m3background
    property color colLayer1: m3colors.m3surfaceContainer
    property color colLayer2: m3colors.m3surfaceContainerHigh
    property color colPrimary: m3colors.m3primary
    property color colPrimaryContainer: m3colors.m3primaryContainer
    property color colText: m3colors.m3onSurface
    property color colTextMuted: m3colors.m3onSurfaceVariant
}
