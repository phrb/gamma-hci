import QtQuick 2.2
import QtQuick.Window 2.1
import QtMultimedia 5.0
import "../../api"

GammaGame {

    id: fut

    function button1() {
        if (campo.state === "ResultadoFinal"){
            campo.state = "MarcacaoDePenaltis"
            campo.novoPenalty()
            jogador_placar.reiniciar()
        } else {
            if (intensidade_remate.rodar === true){
                intensidade_remate.rodar = false
                penalty.intensidade = intensidade_remate.intensidade
                penalty.rodar = true
                apito.play();
            } else if (direcao_remate.rodar === true){
                intensidade_remate.rodar = true
                direcao_remate.rodar = false
                penalty.direcao = direcao_remate.direcao
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: button1()
    }
    // Criando o campo
    Item{
        id: campo
        anchors.fill: parent
        width: parent.width
        height: parent.height
        property bool marcandoPenaltis: true
        property int numeroDeGolosDoJogador: 0
        property int numeroDeGolosDoComputador: 0
        state: "MarcacaoDePenaltis"
        // Imagem do relvado
        Image {
            id: relvado
            anchors.fill: parent
            source: "imagens/campo.png"
            z:0
        }
        // Adicionando a minitela de saida
        Saida{
            id: sair
            anchors.centerIn: parent
            z:-1
        }
        Golo{
            id: animacao_golo
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.05
            state: "antes_do_penalty"
            chute: true
        }
        // Adicionando os placares de jogo
        Placar{ // Placar do Jogador
            id: jogador_placar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.05
        }
        // Adicionando o seletor da direcao do remate
        DirecaoDoRemate{
            id: direcao_remate
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.05
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.05
        }
        // Adicionando o seletor da intensidade do remate
        IntensidadeDoRemate{
            id: intensidade_remate
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.05
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.05
        }
        // Adicionando o jogador que vai marcar o penalty
        AtacanteVsGuardaRedes{
            id: penalty
            width: parent.width * 0.3
            height: parent.height * 0.75
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.095
            anchors.left: parent.left
            anchors.leftMargin: (parent.width - penalty.width + 50)/2
        }

        function novoPenalty(){
            direcao_remate.reiniciar()
            intensidade_remate.reiniciar()
            animacao_golo.reiniciar()
            penalty.reiniciar()
        }

        states: [
            State {
                name: "MarcacaoDePenaltis"
                PropertyChanges {
                    target:sair
                    z:-1
                }
                PropertyChanges {
                    target:direcao_remate
                    rodar: true
                }

            },
            State {
                name: "ResultadoFinal"
                PropertyChanges {
                    target:sair
                    z:1
                }
                PropertyChanges {
                    target:direcao_remate
                    rodar: false
                }
            }
        ]

        SoundEffect {
            id: apito
            source: "sons/apito.wav"
        }

        SoundEffect {
            id: torcida
            source: "sons/publico.wav"
            volume: 0.5
            loops: SoundEffect.Infinite
        }

        Component.onCompleted: {
            torcida.play();
        }
    }
}
