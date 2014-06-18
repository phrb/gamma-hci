import QtQuick 2.0
import QtMultimedia 5.0

Rectangle{
    id: alien
    width: 100
    height: 100
    objectName: "alien"
    color: "transparent"
    state: "alive"

    AnimatedImage {
        id: image
        anchors.fill: parent
        source: "imagens/enemy.gif"
    }

    onStateChanged: {
        if (state === "dead") {
            explosion.play();
        }
    }

    SoundEffect {
        id: explosion
        source: "efeitos_sonoros/explosion.wav"
        volume: 0.3
        onPlayingChanged: {
            if (!playing) {
                spaceInvaders.currentAliens--;
                alien.destroy();
            }
        }
    }

    states: [
        State {
            name: "dead"
            PropertyChanges { target: image; source: "imagens/explosion.gif" }
        },
        State {
            name: "alive"
            PropertyChanges { target: alien; opacity: 1; scale: 1 }
        }
    ]

    transitions: [
        Transition {
            from: "alive"
            to: "dead"
            NumberAnimation {
                duration: 750
                properties: "scale,opacity"
            }
        }
    ]
}
