import QtQuick 2.2
import QtQuick.Window 2.1
import "../../api"

GammaGame {

    id: fut

    function button1() {
        if (intensidade_remate.rodar === true){
            intensidade_remate.rodar = false
            penalty.intensidade = intensidade_remate.intensidade
            console.log("Intensidade: " + intensidade_remate.intensidade)
            penalty.rodar = true
            jogador_placar.gol = penalty.gol
        } else if (altura_remate.rodar === true) {
            altura_remate.rodar = false
            direcao_remate.rodar = true
            penalty.altura = altura_remate.altura
            console.log("Altura: " + altura_remate.altura)
        } else if (direcao_remate.rodar === true){
            intensidade_remate.rodar = true
            direcao_remate.rodar = false
            penalty.direcao = direcao_remate.direcao
            console.log("Direcao: " + direcao_remate.direcao)
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: button1()
    }
    // Criando o campo
    Item{
        id: campo
        width: 1000
        height: 600
        x:0
        y:0
        // Imagem do relvado
        Image {
            id: relvado
            width: 1000
            height: 600
            anchors.fill: parent
            source: "imagens/campo.png"
            z:0
        }
        // Adicionando os placares de jogo
        Placar{ // Placar do Jogador1
            id: jogador_placar
            x:13
            y:7
            texto: "Jogador"
        }
        Placar{ // Placar do Jogador2
            id: computador_placar
            x:687
            y:7
            texto: "Computador"
        }
        // Adicionando o seletor da altura do remate
        AlturaDoRemate{
            id: altura_remate
            x:100
            y:490
            rodar: true
        }
        // Adicionando o seletor da direcao do remate
        DirecaoDoRemate{
            id: direcao_remate
            x:420
            y:500
        }
        // Adicionando o seletor da intensidade do remate
        IntensidadeDoRemate{
            id: intensidade_remate
            x:800
            y:470
        }
        // Adicionando o jogador que vai marcar o penalty
        AtacanteVsGuardaRedes{
            id: penalty
            x:508
            y:365
        }
    }

    /*
    // Adicionando o seletor da altura do remate
    DirecaoDaDefesa{
        id: defesa_remate
        x:410
        y:500
    }
    */
}
