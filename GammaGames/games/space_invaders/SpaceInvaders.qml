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
    id: game0
    timeout_seconds: 10
    property int direction: 1
    property int velocity: 5
    property bool waiting: false

    Grid{
       anchors.horizontalCenter: parent.horizontalCenter
        columns: 10
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
            AnimatedImage {
                source: "imagens/enemy.gif"
            }
    }

    SoundEffect{
        id: shoot
        source: "efeitos_sonoros/shoot.wav"
    }

    function button1(){
        if (game0.waiting) {
            return
        }

        game0.waiting = true;

        shoot.play()
        var newObject = Qt.createComponent("Tiro.qml")
        newObject.createObject(game0, {"x": ship.x + ship.width/2, "y": ship.y});
        waitShotTimer.start()
    }

    Timer{
        id: waitShotTimer
        interval: 700
        running: false
        repeat: false

        onTriggered: {
            game0.waiting  = false;
        }
    }

    ParticleSystem {
        anchors.fill: parent

        // renders a tiny image
        ImageParticle {
            source: "../../api/imgs/particle.png"
        }

        // emit particle object with a size of 20 pixels
        Emitter {
            anchors.fill: parent
            size: 20
        }
    }

    Image {
        id: ship
        width: parent.width * 0.05
        height: parent.width * 0.05
        source: "imagens/nave.png"
        y: parent.height * 0.8
        x: parent.width * 0.475
    }

    Timer {
            interval: 10; running: true; repeat: true
            onTriggered: {
                ship.x += velocity * direction
                if(ship.x >= parent.width - 50 || ship.x <= 0){
                    direction = direction * -1
                }

            }
        }
}
