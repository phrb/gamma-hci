import QtQuick 2.2
import QtQuick.Particles 2.0

Rectangle {
    id: animation
    width: sceneLoader.width
    height: sceneLoader.height
    color: "black"
    anchors.fill: parent

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

    focus: true
    Keys.onLeftPressed: ship.x -= 10
    Keys.onRightPressed: ship.x += 10
    Keys.onDownPressed: ship.y += 10
    Keys.onUpPressed: ship.y -= 10
    Keys.onEscapePressed: sceneLoader.source = sceneLoader.menuSource

}
