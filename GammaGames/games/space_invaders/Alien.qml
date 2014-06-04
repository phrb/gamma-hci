import QtQuick 2.0

Rectangle{
    id: alien
    z: 0
    width:100
    height: 100
    color: "transparent"
    property bool dead: false
    AnimatedImage {
        anchors.fill: parent
        source: "imagens/enemy.gif"
    }
    function death(){
        alien.dead = true
        alien.z = -1
    }
}
