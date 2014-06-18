import QtQuick 2.2

Rectangle {
    id:golo
    width: 300
    height: 180
    color: "transparent"
    property bool estado: false
    property bool chute: false
    Image {
        id: fundo
        anchors.fill: parent
        width: 300
        height: 180
        source: "imagens/golo.png"
        enabled: false
    }
    Text {
        id: golo_texto
        font.pointSize: 40
        font.bold: true
        SequentialAnimation on color {
            id: animacao
            running: golo.estado
            loops: Animation.Infinite
            ColorAnimation { to: "white"; duration: 500}
            ColorAnimation { to: "yellow"; duration: 500}
        }
    }

    states: [
        State {
            name: "antes_do_penalty"
            PropertyChanges {
                target: fundo
                opacity: 0
            }
            PropertyChanges {
                target: golo_texto
                text: "Chute!!"
                color: "black"
                anchors.centerIn: golo
            }
        },
        State {
            name: "depois_do_penalty"
            PropertyChanges {
                target: fundo
                opacity: 1
            }
            PropertyChanges {
                target: golo_texto
                text: golo.estado ? "Golo!!" : "Falhanço!!"
                anchors.topMargin: golo.height * 0.2
                anchors.rightMargin: golo.width * 0.1
                color: golo.estado ? "yellow" : "red"
            }
            AnchorChanges{
                target: golo_texto
                anchors.top: golo.top
                anchors.right: golo.right
            }
        }
    ]

    function golo_estado(e){
        golo.estado = e
        golo.state = "depois_do_penalty"
    }

    function reiniciar(){
        golo.estado = false
        golo.state = "antes_do_penalty"
    }
}
