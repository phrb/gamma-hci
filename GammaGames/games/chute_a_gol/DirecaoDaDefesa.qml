import QtQuick 2.2

Item {
    id: raiz

    Image {
        id: defesa
        height: 70
        width: 200
        source: "imagens/defesa.png"
        z:0
    }

    Image {
        id: remate
        width: 30
        height: 30
        source: "imagens/ring3.png"
        z:1
        y: defesa.height/2 - 15
        x: Math.ceil((Math.random()*(defesa.width - remate.width)))
        rotation: 0
    }

    Image {
        id: seletor
        width: 25
        height: 25
        source: "imagens/bola.png"
        z:2
        y: defesa.height/2 - 13
        x: 0
    }

    ParallelAnimation {
        id: animacao
        running: true
        SequentialAnimation {
            loops: Animation.Infinite
            NumberAnimation {target: seletor; property: "x"; to:defesa.width - remate.width; duration: 1000 }
            NumberAnimation {target: seletor; property: "x"; to: 0; duration: 1000 }
        }
        RotationAnimation {target: remate; property: "rotation"; to: 360; duration: 1000; loops: Animation.Infinite}
    }

    // Teste
    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(seletor.x <= (remate.width+remate.x) && bola.x >= remate.x ){console.log("Defendeu!")}else{console.log("Falhou!")}
            animacao.stop()
        }
    }

}



