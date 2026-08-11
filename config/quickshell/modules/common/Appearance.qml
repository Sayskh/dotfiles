import QtQuick
import Quickshell
import "./functions"

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root

    property QtObject font: QtObject {
        property string family: "Inter"
        property string monospace: "JetBrainsMono Nerd Font"
        property string symbols: "Material Symbols Rounded"
    }

    property QtObject rounding: QtObject {
        property int full: 9999
        property int extraLarge: 28
        property int large: 16
        property int medium: 12
        property int small: 8
        property int extraSmall: 4
        property int none: 0
    }

    property QtObject sizes: QtObject {
        property int barHeight: 44
        property int dockHeight: 64
        property int iconSize: 20
        property int iconSizeLarge: 24
        property int iconSizeSmall: 16
    }

    property QtObject animationCurves: QtObject {
        readonly property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.90, 1, 1]
        readonly property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1.00, 1, 1]
        readonly property list<real> expressiveSlowSpatial: [0.39, 1.29, 0.35, 0.98, 1, 1]
        readonly property list<real> expressiveEffects: [0.34, 0.80, 0.34, 1.00, 1, 1]
        readonly property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
        readonly property list<real> standard: [0.2, 0, 0, 1, 1, 1]
        readonly property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
    }

    property QtObject animation: QtObject {
        property int fast: 150
        property int normal: 250
        property int slow: 400
        property int easingType: Easing.OutCubic
    }

    property QtObject m3colors: QtObject {
        property bool darkmode: true

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

        property color m3primary: "#cbc4cb"
        property color m3onPrimary: "#322f34"
        property color m3primaryContainer: "#2d2a2f"
        property color m3onPrimaryContainer: "#bcb6bc"

        property color m3secondary: "#cac5c8"
        property color m3onSecondary: "#322f32"
        property color m3secondaryContainer: "#484548"
        property color m3onSecondaryContainer: "#e6e1e5"

        property color m3tertiary: "#d3c2c8"
        property color m3onTertiary: "#382d32"
        property color m3tertiaryContainer: "#504348"
        property color m3onTertiaryContainer: "#efdee4"

        property color m3outline: "#948f94"
        property color m3outlineVariant: "#49464a"
        property color m3shadow: "#000000"
        property color m3scrim: "#000000"
    }

    property QtObject colors: QtObject {
        property color colSubtext: m3colors.m3outline
        property color colLayer0: m3colors.m3background
        property color colOnLayer0: m3colors.m3onBackground
        property color colLayer1: m3colors.m3surfaceContainerLow
        property color colOnLayer1: m3colors.m3onSurfaceVariant
        property color colLayer2: m3colors.m3surfaceContainer
        property color colOnLayer2: m3colors.m3onSurface
        property color colLayer3: m3colors.m3surfaceContainerHigh
        property color colOnLayer3: m3colors.m3onSurface
        property color colLayer4: m3colors.m3surfaceContainerHighest
        property color colOnLayer4: m3colors.m3onSurface

        property color colPrimary: m3colors.m3primary
        property color colOnPrimary: m3colors.m3onPrimary
        property color colPrimaryContainer: m3colors.m3primaryContainer
        property color colOnPrimaryContainer: m3colors.m3onPrimaryContainer

        property color colSecondary: m3colors.m3secondary
        property color colOnSecondary: m3colors.m3onSecondary
        property color colSecondaryContainer: m3colors.m3secondaryContainer
        property color colOnSecondaryContainer: m3colors.m3onSecondaryContainer
    }

    // Convenient aliases
    property color colLayer0: colors.colLayer0
    property color colLayer1: colors.colLayer1
    property color colLayer2: colors.colLayer2
    property color colPrimary: colors.colPrimary
    property color colPrimaryContainer: colors.colPrimaryContainer
    property color colText: colors.colOnLayer2
    property color colTextMuted: colors.colOnLayer1
}
