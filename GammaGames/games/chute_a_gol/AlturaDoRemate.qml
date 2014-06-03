import QtQuick 2.2

Item {
    id: raiz
    property real altura: 0
    property bool rodar: false

    Image {
        id: altura
        height: 80
        width: 200
        source: "imagens/altura.png"
        z:0
    }

    Image {
        id: seletor
        width: 25
        height: 25
        source: "imagens/bola.png"
        z:1
        y: altura.height
        x: (altura.width - seletor.width)/2
        SequentialAnimation on y{
            id: animacao
            running: raiz.rodar
            loops: Animation.Infinite
            NumberAnimation {to: 0; duration: 1000}
            NumberAnimation {to: altura.height - seletor.height; duration: 1000}
        }
    }

    onRodarChanged: {
        var aux = ((altura.height - seletor.height - seletor.y)*100)/(altura.height - seletor.height)
        if (raiz.rodar === false) {
            console.log("AlturaDoRemate: " + aux)
            raiz.altura = (aux >= 90 ? 1 : 0)
        }
    }

    function reiniciar(){
        raiz.altura = 0
        raiz.rodar = true
        seletor.y = altura.height
    }
}




