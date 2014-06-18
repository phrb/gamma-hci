import QtQuick 2.2

Rectangle {
    id: raiz
    property real intensidade: 50
    property bool rodar: false
    width: 50
    height: 100
    color:"transparent"

    Image {
        id: intensidade
        source: "imagens/intensidade2.png"
        anchors.fill: parent
    }

    Image {
        id: seletor
        width: 25
        height: 25
        z: 1
        x: -3.5
        y: (raiz.height - seletor.height)/2
        source: "imagens/bola.png"
        SequentialAnimation on y {
            id: animacao
            running: raiz.rodar
            loops: Animation.Infinite
            NumberAnimation {to: raiz.height - seletor.height; duration: 1000}
            NumberAnimation {to: 0; duration: 1000}
        }
    }

    onRodarChanged: {
        if (raiz.rodar === false){
            raiz.intensidade = ((seletor.y*1000)/(raiz.height - seletor.height))+200
        }
    }

    function reiniciar(){
        raiz.intensidade = 50
        seletor.y = (raiz.height - seletor.height)/2
        raiz.rodar = false
    }
}



