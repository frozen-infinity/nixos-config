pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import "Palette.js" as Palette

Item {
    id: tokens

    readonly property string colorsPath: Qt.resolvedUrl("theme/colors.toml").toString()

    property var _derived: Palette.derive({
        background: "#0d0d0f", foreground: "#e8e8e8", accent: "#cba6f7",
        color1: "#f38ba8", color2: "#a6e3a1", color3: "#f9e2af",
        color4: "#89b4fa", color7: "#cdd6f4", color8: "#585b70"
    })

    readonly property color background: colorOrTransparent("background")
    readonly property color backgroundAlt: colorOrTransparent("backgroundAlt")
    readonly property color surface: colorOrTransparent("surface")
    readonly property color surfaceTranslucent: Qt.rgba(
        surface.r, surface.g, surface.b, _derived ? 0.92 : 0
    )
    readonly property color foreground: colorOrTransparent("foreground")
    readonly property color foregroundMuted: colorOrTransparent("foregroundMuted")
    readonly property color border: colorOrTransparent("border")
    readonly property color borderMuted: colorOrTransparent("borderMuted")
    readonly property color selectedBackground: colorOrTransparent("selectedBackground")
    readonly property color selectedForeground: colorOrTransparent("selectedForeground")
    readonly property color accent: colorOrTransparent("accent")
    readonly property color accentMuted: Qt.rgba(accent.r, accent.g, accent.b, _derived ? 0.34 : 0)
    readonly property color danger: colorOrTransparent("danger")
    readonly property color warning: colorOrTransparent("warning")
    readonly property color success: colorOrTransparent("success")
    readonly property color shadow: Qt.rgba(
        colorOrTransparent("shadow").r,
        colorOrTransparent("shadow").g,
        colorOrTransparent("shadow").b,
        _derived ? 0.46 : 0
    )

    readonly property int radius: 6
    readonly property int spacing: 6
    readonly property string fontFamily: "monospace"
    readonly property int fontSize: 12

    function colorOrTransparent(name) {
        return _derived && Palette.validColor(_derived[name])
            ? _derived[name]
            : Qt.rgba(0, 0, 0, 0);
    }

    function applyText(text) {
        const next = Palette.derive(Palette.parse(text));
        if (next) _derived = next;
    }

    function reload() {
        paletteFile.reload();
    }

    FileView {
        id: paletteFile
        path: tokens.colorsPath
        watchChanges: true
        onFileChanged: reload()
        onLoaded: tokens.applyText(text())
    }

    Component.onCompleted: paletteFile.reload()
}
