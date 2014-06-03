import QtQuick 2.2
import QtQuick.Window 2.1
import "../../api"

GammaGame {

    id: fut

    function button1() {
        if (campo.state === "ResultadoFinal"){
            campo.state = "MarcacaoDePenaltis"
            jogador_placar.reiniciar()
            computador_placar.reiniciar()
        } else {
            if (intensidade_remate.rodar === true){
                intensidade_remate.rodar = false
                penalty.intensidade = intensidade_remate.intensidade
                penalty.rodar = true
            } else if (altura_remate.rodar === true) {
                altura_remate.rodar = false
                direcao_remate.rodar = true
                penalty.altura = altura_remate.altura
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
        width: 1000
        height: 600
        property bool marcandoPenaltis: true
        property int numeroDeGolosDoJogador: 0
        property int numeroDeGolosDoComputador: 0
        state: "MarcacaoDePenaltis"
        // Imagem do relvado
        Image {
            id: relvado
            width: 1000
            height: 600
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
        // Adicionando os placares de jogo
        Placar{ // Placar do Jogador1
            id: jogador_placar
            x:40
            y:7
            texto: "Jogador"
        }
        Placar{ // Placar do Jogador2
            id: computador_placar
            x:950
            y:7
            texto: "Computador"
        }
        // Adicionando o seletor da altura do remate
        AlturaDoRemate{
            id: altura_remate
            x:200
            y:600
            rodar: true
        }
        // Adicionando o seletor da direcao do remate
        DirecaoDoRemate{
            id: direcao_remate
            x:520
            y:605
        }
        // Adicionando o seletor da intensidade do remate
        IntensidadeDoRemate{
            id: intensidade_remate
            x:950
            y:575
        }
        // Adicionando o jogador que vai marcar o penalty
        AtacanteVsGuardaRedes{
            id: penalty
            x:650
            y:398
        }

        function novoPenalty(){
            altura_remate.reiniciar()
            direcao_remate.reiniciar()
            intensidade_remate.reiniciar()
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
                    target:altura_remate
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
                    target:altura_remate
                    rodar: false
                }
            }
        ]

        /*transitions: [
            Transition {
                from: "MarcacaoDePenaltis"
                to: "ResultadoFinal"
            },
            Transition {
                from: "ResultadoFinal"
                to: "MarcacaoDePenaltis"
            }
        ]*/
    }
}
