import QtQuick 2.2

Item {
    id: raiz
    property real intensidade: 50
    property bool rodar: false

    Image {
        id: intensidade
        width: 50
        height: 100
        z: 0
        x:0
        y:0
        source: "imagens/intensidade.png"
    }

    Image {
        id: seletor
        width: 25
        height: 25
        z: 1
        x: -3.5
        y: (intensidade.height - seletor.height)/2
        source: "imagens/bola.png"
        SequentialAnimation on y {
            id: animacao
            running: raiz.rodar
            loops: Animation.Infinite
            NumberAnimation {to: intensidade.height - seletor.height; duration: 1000}
            NumberAnimation {to: 0; duration: 1000}
        }
    }

    onRodarChanged: {
        if (raiz.rodar === false){
            raiz.intensidade = (seletor.y*1000)/(intensidade.height - seletor.height)
        }
    }

    function reiniciar(){
        raiz.intensidade = 50
        raiz.rodar = false
        seletor.y = (intensidade.height - seletor.height)/2
    }
}



