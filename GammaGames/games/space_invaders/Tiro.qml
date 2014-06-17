import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    id: tiro
    color: "transparent"

    AnimatedImage{
        anchors.fill: parent
        source: "imagens/shot.gif"
    }
    SequentialAnimation on y {
        id: yAnim
        running: true
        NumberAnimation { to: 0; duration: 1600000/spaceInvaders.height }
    }

    SoundEffect {
        id: shoot
        source: "efeitos_sonoros/shoot.wav"
    }

    onYChanged: {
        var enemy = alienArea.childAt(x+width/2.0,y);
        if (enemy !== null && enemy.objectName === "alien") {
            enemy.state = "dead";
            tiro.destroy();
        }
        else if (tiro.y === 0) {
            tiro.destroy();
        }
    }

    Component.onCompleted: {
        shoot.play();
    }
}
