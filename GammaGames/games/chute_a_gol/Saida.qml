import QtQuick 2.2

Item{
    id: telaDeSaida
    property string texto: "PIHC"
    Rectangle {
        id: tela
        x:-150
        y:-90
        width: 300
        height: 180
        color: "grey"
        opacity: 0.5
    }
    Rectangle {
        id: retangulo1
        x:-150
        y:-90
        width: 300
        height: 90
        color: "transparent"
        Text {
            anchors.centerIn: parent
            text: telaDeSaida.texto
            color: "green"
            font.pointSize: 30
            style: Text.Outline
            styleColor: "yellow"
        }
    }
    Rectangle {
        id: retangulo2
        x:-150
        y:0
        width: 300
        height: 90
        color: "transparent"
        Text {
            anchors.centerIn: parent
            text: "Para cancelar o timeup e voltar ao jogo, \npessione o botão!"
            color: "red"
            font.pointSize: 10
            style: Text.Outline
            styleColor: "black"
        }
    }
}
