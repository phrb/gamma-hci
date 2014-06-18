import QtQuick 2.2
import QtMultimedia 5.0

Rectangle {
    id: raiz
    x:0
    y:0
    property real direcao: 0
    property real intensidade: 0
    property real direcaoSalto: 0
    property real velocidadeSalto: 0
    property bool rodar: false
    property real lasty: 0
    property real lastx: 0
    color:"transparent"

    Rectangle{
        id: baliza_localizacao
        width: parent.width
        height: parent.height/4
        z:1
        anchors.top:parent.top
        color: "transparent"
        // Imagem de baliza
        Image {
            id:baliza
            width: parent.width*0.9
            height: parent.height
            anchors.top:parent.top
            anchors.left:parent.left
            anchors.leftMargin: (parent.width - baliza.width)/2
            source: "imagens/baliza.png"
            x: (parent.width - baliza.width)/2
        }
    }

    Rectangle{
        id: guardaredes
        width: 30
        height: 30
        z: 0
        anchors.bottom:baliza_localizacao.bottom
        anchors.bottomMargin: -1 * guardaredes.width/2
        x: (parent.width - guardaredes.width)/2
        color: "transparent"
        Image {
            width: 30
            height: 30
            source: "imagens/guarda_redes_2.png"
        }
        RotationAnimation on rotation {to: 180; duration: 1}
        NumberAnimation on x {id:animacao_guardaredes; running:false; to:raiz.direcaoSalto; duration: raiz.velocidadeSalto}
    }

    Rectangle {
        id: bola
        width: 15
        height: 15
        z:0
        y:parent.height*0.69
        x:(parent.width - guardaredes.width)/2
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
                NumberAnimation { target: bola; property: "x"; to: baliza_localizacao.x + baliza.x + (baliza.width + 55)*raiz.direcao; duration: raiz.intensidade }
                NumberAnimation { target: bola; property: "y"; to: baliza_localizacao.y; duration: raiz.intensidade }
                RotationAnimation { target: bola; property: "rotation"; to: 360; duration: raiz.intensidade }
            }
        }
        onXChanged: {
            mudo_golo()
            if(guardaredes.x <= bola.x + bola.width && bola.x <= guardaredes.x + guardaredes.width
                    && guardaredes.y <= bola.y + bola.height && bola.y <= guardaredes.y + guardaredes.height
                    && bola.y !== raiz.lasty && bola.x !== raiz.lastx){
                raiz.lastx = bola.x
                raiz.lasty = bola.y
                golo_falhado_som.play()
                jogador_placar.atualizacao(false)
                animacao_golo.golo_estado(false)
                animacao_bola.stop()
                animacao_guardaredes.stop()
                jogador_placar.incrementaPenaltisMarcados()
            } else if(baliza_localizacao.x + baliza.x >= bola.x || baliza_localizacao.x + baliza.x + baliza.width - bola.width <= bola.x){
                golo_som.play()
                jogador_placar.atualizacao(true)
                animacao_golo.golo_estado(true)
                animacao_bola.stop()
                jogador_placar.incrementaPenaltisMarcados()
            }
        }
        onYChanged: {
            mudo_golo()
            if(guardaredes.x <= bola.x + bola.width && bola.x <= guardaredes.x + guardaredes.width
                    && guardaredes.y <= bola.y + bola.height && bola.y <= guardaredes.y + guardaredes.height
                    && bola.y !== raiz.lasty && bola.x !== raiz.lastx){
                raiz.lastx = bola.x
                raiz.lasty = bola.y
                golo_falhado_som.play()
                jogador_placar.atualizacao(false)
                animacao_golo.golo_estado(false)
                animacao_bola.stop()
                animacao_guardaredes.stop()
                jogador_placar.incrementaPenaltisMarcados()
            } else if(baliza_localizacao.y == bola.y){
                golo_som.play()
                jogador_placar.atualizacao(true)
                animacao_golo.golo_estado(true)
                animacao_bola.stop()
                jogador_placar.incrementaPenaltisMarcados()
            }
        }
    }

    Rectangle{
        id: atacante
        width: 30
        height: 30
        z: 0
        x: (parent.width - atacante.width - 15)/2
        y: parent.height*0.9
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
                chute.play()
                animacao_atacante.stop()
                animacao_bola.running = true
                raiz.direcaoSalto = baliza_localizacao.x + baliza.x + ((Math.random()*(baliza.width - guardaredes.width/2)) + guardaredes.width)
                raiz.velocidadeSalto = (Math.random()*1000)+200
                animacao_guardaredes.running = true
            }
        }
    }

    function reiniciar(){
        raiz.direcao = 0
        raiz.intensidade = 0
        raiz.rodar = false
        bola.y=raiz.height*0.69
        bola.x=(raiz.width - guardaredes.width)/2
        animacao_bola.running = false
        atacante.x = (raiz.width - atacante.width - 15)/2
        atacante.y = raiz.height*0.9
        guardaredes.x = (raiz.width - guardaredes.width)/2
        animacao_guardaredes.running = false
    }

    function mudo_golo(){
        golo_som.stop()
        golo_falhado_som.stop()
    }

    SoundEffect {
        id: chute
        source: "sons/kick.wav"
    }

    SoundEffect {
        id: golo_som
        source: "sons/goal.wav"
    }

    SoundEffect {
        id: golo_falhado_som
        source: "sons/miss.wav"
    }

}
