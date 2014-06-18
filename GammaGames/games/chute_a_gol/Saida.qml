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
        border.color: "black"
    }

    Text {
        anchors.centerIn: parent
        text: telaDeSaida.texto
        color: "yellow"
        font.pointSize: 50
        font.bold: true
        style: Text.Outline
        styleColor: "black"
    }
}
