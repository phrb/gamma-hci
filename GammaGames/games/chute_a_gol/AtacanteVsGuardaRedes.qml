import QtQuick 2.2

Item {
    id: raiz
    property real direcao: 0
    property real altura: 0
    property real intensidade: 0
    property bool rodar: false
    property bool gol: false

    Rectangle{
        id: baliza
        width: 200
        height: 100
        z:1
        x:-90
        y:-295
        color: "transparent"
        // Imagem de baliza
        Image {
            width: 200
            height: 100
            source: "imagens/baliza.png"
        }
    }

    Rectangle{
        id: guardaredes
        width: 30
        height: 30
        z: 0
        x: -9
        y: -210
        color: "transparent"

        Image {
            width: 30
            height: 30
            source: "imagens/guarda_redes_2.png"
        }
        RotationAnimation on rotation {to: 180; duration: 1}
        /*NumberAnimation on x {id:ania; to:300; duration: 2000}*/
    }

    Rectangle {
        id: bola
        width: 15
        height: 15
        z:raiz.altura
        y:0
        x:0
        color: "transparent"
        Image {
            width: 15
            height: 15
            source: "imagens/bola.png"
        }
        SequentialAnimation {
            id: animacao_bola
            running: false
            ParallelAnimation{
                NumberAnimation { target: bola; property: "x"; to: baliza.x + raiz.direcao; duration: raiz.intensidade }
                NumberAnimation { target: bola; property: "y"; to: -295; duration: raiz.intensidade }
                RotationAnimation { target: bola; property: "rotation"; to: 360; duration: raiz.intensidade }
            }
        }
        onXChanged: {
            if(guardaredes.x <= bola.x + bola.width && bola.x <= guardaredes.x + guardaredes.width
                    && guardaredes.y <= bola.y + bola.height && bola.y <= guardaredes.y + guardaredes.height){
                animacao_bola.stop()
                raiz.gol = false;
            } else if(baliza.x >= bola.x || baliza.x + baliza.width - bola.width <= bola.x || baliza.y >= bola.y){
                animacao_bola.stop()
                if(raiz.altura === 0){
                    raiz.gol = true
                } else {

                }
            }
        }
    }

    Rectangle{
        id: atacante
        width: 30
        height: 30
        z: 0
        x:-9
        y:90
        color: "transparent"

        Image {
            width: 30
            height: 30
            source: "imagens/jogador_1.png"
        }

        NumberAnimation on y {id:animacao_atacante; running: raiz.rodar; to:0; duration: 1000}

        onYChanged: {
            if(atacante.x <= bola.x + bola.width && bola.x <= atacante.x + atacante.width
                    && atacante.y <= bola.y + bola.height && bola.y <= atacante.y + atacante.height){
                animacao_atacante.stop()
                animacao_bola.running = true
                //animacao_guardaredes = true
            }
        }
    }

}
