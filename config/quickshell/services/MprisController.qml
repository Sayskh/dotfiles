pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import "../modules/common"

Singleton {
    id: root

    property list<var> players: Mpris.players.values
    property string selectedPlayerIdentity: ""

    property var activePlayer: {
        const list = Mpris.players.values;
        if (!list || list.length === 0) return null;
        if (root.selectedPlayerIdentity.length > 0) {
            const selected = list.find(p => p.identity === root.selectedPlayerIdentity);
            if (selected) return selected;
        }
        const playing = list.find(p => p.isPlaying);
        if (playing) return playing;
        const spotify = list.find(p => p.identity?.toLowerCase().includes("spotify"));
        if (spotify) return spotify;
        return list[0];
    }

    property string title: activePlayer?.trackTitle || "No Media Playing"
    property string artist: activePlayer?.trackArtist || "Unknown Artist"
    property string album: activePlayer?.trackAlbum || ""
    property string artUrl: activePlayer?.trackArtUrl || Images.defaultCoverArt
    property real position: activePlayer?.position ?? 0
    property real length: activePlayer?.length ?? 0
    property real progress: length > 0 ? (position / length) : 0

    property bool isPlaying: activePlayer?.isPlaying ?? false
    property bool canControl: activePlayer?.canControl ?? false
    property bool canPlay: activePlayer?.canControl ?? false
    property bool canGoNext: activePlayer?.canGoNext ?? false
    property bool canGoPrevious: activePlayer?.canGoPrevious ?? false
    property bool shuffle: activePlayer?.shuffle ?? false
    property int loopStatus: activePlayer?.loopStatus ?? 0

    Timer {
        id: positionTimer
        interval: 500
        running: root.isPlaying
        repeat: true
        onTriggered: {
            if (root.activePlayer && root.activePlayer.position !== undefined) {
                root.position = root.activePlayer.position;
            }
        }
    }

    function selectPlayer(identity: string) {
        root.selectedPlayerIdentity = identity;
    }

    function togglePlaying() {
        if (activePlayer?.canTogglePlaying) activePlayer.togglePlaying();
    }

    function next() {
        if (activePlayer?.canGoNext) activePlayer.next();
    }

    function previous() {
        if (activePlayer?.canGoPrevious) activePlayer.previous();
    }

    function stop() {
        if (activePlayer?.canStop) activePlayer.stop();
    }

    function setPosition(pos: real) {
        if (activePlayer && activePlayer.position !== undefined) {
            activePlayer.position = pos;
        }
    }

    function formatTime(seconds: real): string {
        if (isNaN(seconds) || seconds < 0) return "0:00";
        const mins = Math.floor(seconds / 60);
        const secs = Math.floor(seconds % 60);
        return `${mins}:${secs < 10 ? '0' : ''}${secs}`;
    }
}
