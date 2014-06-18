import QtQuick 2.2

Rectangle {
    id: raiz
    property real direcao: 0
    property bool rodar: false
    height: 70
    width: 200
    color:"transparent"

    Image {
        id: direcao    
        source: "imagens/direcao2.png"
        anchors.fill: parent
    }

    Image {
        id: seletor
        width: 25
        height: 25
        source: "imagens/bola.png"
        z:1
        x: (direcao.width - seletor.width)/2
        y: direcao.height - seletor.height + 5
        SequentialAnimation on x {
            id: animacao
            running: raiz.rodar
            loops: Animation.Infinite
            NumberAnimation { to: direcao.width - seletor.width; duration: 1000 }
            NumberAnimation { to: 0; duration: 1000 }
        }
    }

    onRodarChanged: {
        if (raiz.rodar === false){
            raiz.direcao = seletor.x/direcao.width
        }
    }

    function reiniciar(){
        raiz.direcao = 0
        seletor.x = (direcao.width - seletor.width)/2
        raiz.rodar = true
    }
}
