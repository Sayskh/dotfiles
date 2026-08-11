pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import "../modules/common"

Singleton {
    id: root

    property bool ready: Pipewire.defaultAudioSink?.ready ?? false
    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource
    readonly property real hardMaxValue: 2.00
    property string audioTheme: Config?.options.audio.theme ?? "freedesktop"
    property real value: sink?.audio.volume ?? 0
    property bool muted: sink?.audio.muted ?? false
    property real micValue: source?.audio.volume ?? 0
    property bool micMuted: source?.audio.muted ?? false

    function friendlyDeviceName(node: var): string {
        if (!node) return "Unknown";
        return (node.nickname || node.description || "Unknown");
    }

    function appNodeDisplayName(node: var): string {
        if (!node) return "Unknown";
        return (node.properties["application.name"] || node.description || node.name || "App");
    }

    function correctType(node: var, isSink: bool): bool {
        return (node.isSink === isSink) && node.audio != null;
    }

    function appNodes(isSink: bool): var {
        if (!Pipewire.nodes) return [];
        return Pipewire.nodes.values.filter((node) => {
            return root.correctType(node, isSink) && node.isStream;
        });
    }

    function devices(isSink: bool): var {
        if (!Pipewire.nodes) return [];
        return Pipewire.nodes.values.filter((node) => {
            return root.correctType(node, isSink) && !node.isStream;
        });
    }

    readonly property list<var> outputAppNodes: root.appNodes(true)
    readonly property list<var> inputAppNodes: root.appNodes(false)
    readonly property list<var> outputDevices: root.devices(true)
    readonly property list<var> inputDevices: root.devices(false)

    signal sinkProtectionTriggered(reason: string)

    function toggleMute() {
        if (sink?.audio) sink.audio.muted = !sink.audio.muted;
    }

    function toggleMicMute() {
        if (source?.audio) source.audio.muted = !source.audio.muted;
    }

    function incrementVolume(step: real = 0.05) {
        if (!sink?.audio) return;
        const currentVolume = sink.audio.volume;
        const actualStep = step > 0 ? step : (currentVolume < 0.1 ? 0.01 : 0.02);
        sink.audio.volume = Math.min(1.0, sink.audio.volume + actualStep);
    }

    function decrementVolume(step: real = 0.05) {
        if (!sink?.audio) return;
        const currentVolume = sink.audio.volume;
        const actualStep = step > 0 ? step : (currentVolume < 0.1 ? 0.01 : 0.02);
        sink.audio.volume = Math.max(0.0, sink.audio.volume - actualStep);
    }

    function setVolume(val: real) {
        if (sink?.audio) sink.audio.volume = Math.max(0.0, Math.min(root.hardMaxValue, val));
    }

    function setDefaultSink(node: var) {
        Pipewire.preferredDefaultAudioSink = node;
    }

    function setDefaultSource(node: var) {
        Pipewire.preferredDefaultAudioSource = node;
    }

    PwObjectTracker {
        objects: [sink, source]
    }

    Connections {
        target: sink?.audio ?? null
        property bool lastReady: false
        property real lastVolume: 0
        function onVolumeChanged() {
            if (!Config?.options.audio.protection.enable) return;
            const newVolume = sink.audio.volume;
            if (isNaN(newVolume) || newVolume === undefined || newVolume === null) {
                lastReady = false;
                lastVolume = 0;
                return;
            }
            if (!lastReady) {
                lastVolume = newVolume;
                lastReady = true;
                return;
            }
            const maxAllowedIncrease = (Config?.options.audio.protection.maxAllowedIncrease ?? 20) / 100;
            const maxAllowed = (Config?.options.audio.protection.maxAllowed ?? 100) / 100;

            if (newVolume - lastVolume > maxAllowedIncrease) {
                sink.audio.volume = lastVolume;
                root.sinkProtectionTriggered("Illegal volume increment");
            } else if (newVolume > maxAllowed || newVolume > root.hardMaxValue) {
                root.sinkProtectionTriggered("Exceeded max allowed volume");
                sink.audio.volume = Math.min(lastVolume, maxAllowed);
            }
            lastVolume = sink.audio.volume;
        }
    }

    function playSystemSound(soundName: string) {
        const ogaPath = `/usr/share/sounds/${root.audioTheme}/stereo/${soundName}.oga`;
        const oggPath = `/usr/share/sounds/${root.audioTheme}/stereo/${soundName}.ogg`;
        Quickshell.execDetached(["ffplay", "-nodisp", "-autoexit", ogaPath]);
        Quickshell.execDetached(["ffplay", "-nodisp", "-autoexit", oggPath]);
    }
}
