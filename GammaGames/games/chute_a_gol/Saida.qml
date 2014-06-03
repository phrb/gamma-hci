import QtQuick 2.2

Item{
    id: telaDeSaida
    property string texto: "PIHC"
    Rectangle {
        id: tela
        anchors.centerIn: telaDeSaida
        width: 600
        height: 200
        color: "grey"
        opacity: 0.5
    }

    Rectangle {
        id: retangulo1
        x: -300
        y:-100
        width: 600
        height: 100
        color: "transparent"
        Text {
            anchors.centerIn: parent
            text: telaDeSaida.texto
            color: "green"
            font.pointSize: 40
            style: Text.Outline
            styleColor: "yellow"
        }
    }
    Rectangle {
        id: retangulo2
        x:-300
        y:0
        width: 600
        height: 100
        color: "transparent"
        Text {
            anchors.centerIn: parent
            text: "Para cancelar o timeup e voltar ao jogo, pressione o botão!"
            color: "red"
            font.pointSize: 15
            style: Text.Outline
            styleColor: "black"
        }
    }
}
