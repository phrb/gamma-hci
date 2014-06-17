import QtQuick 2.2
import QtQuick.Particles 2.0
import QtMultimedia 5.0

import "../../api"

/*
  Simple extension of GammaGame,
  to test focus changes, MouseArea,
  simple drawing.
 */
GammaGame {
    id: spaceInvaders
    property int timeout_seconds: 10
    property int direction: 1
    property int velocity: 5
    property bool waiting: false
    property int alienWidth: 96
    property int alienHeight: 90
    property int shotWidth: 30
    property int shotHeight: 62
    property int maxAliens: 15
    property int currentAliens: 0

    function button1() {
        if (spaceInvaders.waiting) {
            return
        }

        spaceInvaders.waiting = true;

        var newObject = Qt.createComponent("Tiro.qml")
        newObject.createObject(spaceInvaders, {
            "x": nave.x + (nave.width-shotWidth)/2.0,
            "y": nave.y - shotHeight,
            "width": shotWidth,
            "height": shotHeight,
        });
        waitShotTimer.start()
    }

    Rectangle {
        id: alienArea
        width: parent.width
        height: parent.height*0.75
        color: "transparent"
    }

    Nave {
        id: nave
        x: (parent.width - width)/2.0
        y: parent.height - height - 10
    }

    Timer {
        id: waitShotTimer
        interval: 350
        running: false
        repeat: false

        onTriggered: {
            spaceInvaders.waiting  = false;
        }
    }

    Timer {
        id: alienCreator
        interval: 2000
        running: true
        repeat: true

        onTriggered: {
            if (spaceInvaders.currentAliens < spaceInvaders.maxAliens) {
                var newAlien = Qt.createComponent("Alien.qml");
                var retries = 3;

                var x = Math.random()*(alienArea.width-alienWidth);
                var y = Math.random()*(alienArea.height-alienHeight);
                var overlap = alienArea.childAt(x,y) !== null;

                while (retries > 0 && overlap) {
                    x = Math.random()*(alienArea.width-alienWidth);
                    y = Math.random()*(alienArea.height-alienHeight);
                    overlap = alienArea.childAt(x,y) !== null;
                    retries--;
                }

                if (!overlap) {
                    newAlien.createObject(alienArea, {
                        "x": x,
                        "y": y,
                        "width": alienWidth,
                        "height": alienHeight
                    });
                    spaceInvaders.currentAliens++;
                }
            }
        }
    }

    Timer {
        interval: 10;
        running: true;
        repeat: true

        onTriggered: {
            nave.x += velocity * direction
            if (nave.x + nave.width >= parent.width){
                nave.x = parent.width - nave.width
                direction = direction * -1;
            }
            else if (nave.x <= 0) {
                nave.x = 0;
                direction = direction * -1;
            }
        }
    }

    ParticleSystem {
        anchors.fill: parent

        ImageParticle {
            source: "imagens/particle.png"
        }

        Emitter {
            anchors.fill: parent
            size: 10
        }
    }
}
