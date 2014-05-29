import QtQuick 2.2
import QtQuick.Particles 2.0

/*
  Simple extension of GammaGame,
  to test focus changes, MouseArea,
  simple drawing.
 */
GammaGame {
    id: game0
    timeout_seconds: 5
    function button1(){
        console.log("button1 remaped!")
    }
    ParticleSystem {
        anchors.fill: parent

        // renders a tiny image
        ImageParticle {
            source: "imgs/particle.png"
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
    Rectangle {
        id: ship
        width: parent.width * 0.05
        height: parent.width * 0.05
        color: "skyblue"
        y: parent.height * 0.8
        x: parent.width * 0.475
    }
    Keys.onLeftPressed: ship.x -= 10
    Keys.onRightPressed: ship.x += 10
    Keys.onDownPressed: ship.y += 10
    Keys.onUpPressed: ship.y -= 10
}
