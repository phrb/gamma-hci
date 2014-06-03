import QtQuick 2.2
import QtQuick.Particles 2.0
import "../../api"

/*
  Simple extension of GammaGame,
  to test focus changes, MouseArea,
  simple drawing.
 */
GammaGame {
    id: game0
    timeout_seconds: 2
    property int direction: 1
    property int velocity: 10

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

    function button1(){
        console.log("button1 remaped!")
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
    MouseArea {
        anchors.fill: parent
        onClicked: {
            sceneLoader.source = sceneLoader.menuSource
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

    Keys.onLeftPressed: ship.x -= 10
    Keys.onRightPressed: ship.x += 10
    Keys.onDownPressed: ship.y += 0
    Keys.onUpPressed: ship.y -= 0

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
