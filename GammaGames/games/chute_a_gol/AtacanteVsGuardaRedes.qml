import QtQuick 2.2

Item {
    id: raiz
    property real direcao: 0
    property real altura: 0
    property real intensidade: 0
    property bool rodar: false
    property real lasty: 0
    property real lastx: 0

    Rectangle{
        id: baliza
        width: 250
        height: 100
        z:1
        x:-115
        y:-295
        color: "transparent"
        // Imagem de baliza
        Image {
            width: 250
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
        //NumberAnimation on x {id:ania; to:300; duration: 2000}
    }

    Rectangle {
        id: bola
        width: 15
        height: 15
        z:raiz.altura
        y:45
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
                NumberAnimation { target: bola; property: "y"; to: baliza.y; duration: raiz.intensidade }
                RotationAnimation { target: bola; property: "rotation"; to: 360; duration: raiz.intensidade }
            }
        }
        onXChanged: {
            console.log("baliza.y:" + baliza.y)
            console.log("bola.y:" + bola.y)
            console.log("altura:" + raiz.altura)
            if(guardaredes.x <= bola.x + bola.width && bola.x <= guardaredes.x + guardaredes.width
                    && guardaredes.y <= bola.y + bola.height && bola.y <= guardaredes.y + guardaredes.height
                    && bola.y !== raiz.lasty && bola.x !== raiz.lastx){
                raiz.lastx = bola.x
                raiz.lasty = bola.y
                animacao_bola.stop()
                jogador_placar.atualizacao(false)
                jogador_placar.incrementaPenaltisMarcados()
            } else if(baliza.x >= bola.x || baliza.x + baliza.width - bola.width <= bola.x){
                animacao_bola.stop()
                if(raiz.altura === 0){
                    jogador_placar.atualizacao(true)
                } else {
                    jogador_placar.atualizacao(false)
                }
                jogador_placar.incrementaPenaltisMarcados()
            }
        }
        onYChanged: {
            console.log("baliza.y:" + baliza.y)
            console.log("bola.y:" + bola.y)
            console.log("altura:" + raiz.altura)
            if(guardaredes.x <= bola.x + bola.width && bola.x <= guardaredes.x + guardaredes.width
                    && guardaredes.y <= bola.y + bola.height && bola.y <= guardaredes.y + guardaredes.height
                    && bola.y !== raiz.lasty && bola.x !== raiz.lastx){
                raiz.lastx = bola.x
                raiz.lasty = bola.y
                jogador_placar.atualizacao(false)
                jogador_placar.incrementaPenaltisMarcados()
                animacao_bola.stop()
            } else if(baliza.y == bola.y){
                if(raiz.altura === 0){
                    jogador_placar.atualizacao(true)
                } else {
                    jogador_placar.atualizacao(false)
                }
                jogador_placar.incrementaPenaltisMarcados()
                animacao_bola.stop()
            }
        }

    }

    Rectangle{
        id: atacante
        width: 30
        height: 30
        z: 0
        x:-9
        y:150
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

    function reiniciar(){
        raiz.direcao = 0
        raiz.altura = 0
        raiz.intensidade = 0
        raiz.rodar = false
        bola.x = 0
        bola.y = 0
        animacao_bola.running = false
        atacante.x = -9
        atacante.y = 90
    }

}
