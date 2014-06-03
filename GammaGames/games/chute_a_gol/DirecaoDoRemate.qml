import QtQuick 2.2

Item {
    id: raiz
    property real direcao: 0
    property bool rodar: false

    Image {
        id: direcao
        height: 70
        width: 200
        source: "imagens/direcao.png"
        z:0
        x:0
        y:0
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
            raiz.direcao = seletor.x
        }
    }

    function reiniciar(){
        raiz.direcao = 0
        raiz.rodar = false
        seletor.x = (direcao.width - seletor.width)/2
    }
}
