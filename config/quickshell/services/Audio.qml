import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root

    property bool ready: Pipewire.defaultAudioSink?.ready ?? false
    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource

    property real value: sink?.audio.volume ?? 0
    property bool muted: sink?.audio.muted ?? false

    property real micValue: source?.audio.volume ?? 0
    property bool micMuted: source?.audio.muted ?? false

    function toggleMute() {
        if (sink?.audio) sink.audio.muted = !sink.audio.muted;
    }

    function toggleMicMute() {
        if (source?.audio) source.audio.muted = !source.audio.muted;
    }

    function incrementVolume(step: real = 0.05) {
        if (sink?.audio) sink.audio.volume = Math.min(1.0, sink.audio.volume + step);
    }

    function decrementVolume(step: real = 0.05) {
        if (sink?.audio) sink.audio.volume = Math.max(0.0, sink.audio.volume - step);
    }

    function setVolume(val: real) {
        if (sink?.audio) sink.audio.volume = Math.max(0.0, Math.min(1.0, val));
    }

    PwObjectTracker {
        objects: [sink, source]
    }
}
