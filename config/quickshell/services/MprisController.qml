import QtQuick
import Quickshell
import Quickshell.Services.Mpris

pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root

    property list<MprisPlayer> players: Mpris.players.values
    property MprisPlayer activePlayer: Mpris.players.values[0] ?? null

    property string title: activePlayer?.trackTitle ?? "No Media Playing"
    property string artist: activePlayer?.trackArtist ?? "Unknown Artist"
    property string album: activePlayer?.trackAlbum ?? ""
    property string artUrl: activePlayer?.trackArtUrl ?? ""

    property bool isPlaying: activePlayer?.isPlaying ?? false
    property bool canPlay: activePlayer?.canControl ?? false
    property bool canGoNext: activePlayer?.canGoNext ?? false
    property bool canGoPrevious: activePlayer?.canGoPrevious ?? false

    function togglePlaying() {
        if (activePlayer?.canTogglePlaying) activePlayer.togglePlaying();
    }

    function next() {
        if (activePlayer?.canGoNext) activePlayer.next();
    }

    function previous() {
        if (activePlayer?.canGoPrevious) activePlayer.previous();
    }
}
