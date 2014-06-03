import QtQuick 2.2

Rectangle {
    id: placar
    x:0
    y:0
    width: 300
    height: 180
    color: "transparent"
    state: "placar0"
    property string texto: "Jogador"
    property int golos_marcados: 0
    property int golos_falhados: 0
    property int penaltisMarcados: 0

    Rectangle {
        id: equipa
        x:0
        y:0
        width: 300
        height: 60
        color: "transparent"
        Text {
            anchors.centerIn: parent
            text: placar.texto
            color: "green"
            font.pointSize: 20
            style: Text.Outline
            styleColor: "yellow"
        }
    }

    Rectangle {
        id: golStatus
        x:0
        y:120
        width: 150
        height: 60
        color: "transparent"
        Text {
            anchors.top: parent.top
            anchors.topMargin: 10
            text: "Golos Marcados: " + placar.golos_marcados
            color: "green"
            font.pointSize: 10
            style: Text.Outline
            styleColor: "yellow"
        }
    }

    Rectangle {
        id: golStatus2
        x:150
        y:120
        width: 150
        height: 60
        color: "transparent"
        Text {
            anchors.top: parent.top
            anchors.topMargin: 10
            text: "Golos Falhados: " + placar.golos_falhados
            color: "green"
            font.pointSize: 10
            style: Text.Outline
            styleColor: "yellow"
        }
    }

    Rectangle {
        id: status1
        x:0
        y:60
        width: 60
        height: 60
        radius: 30
        color: "grey"
        property bool gol: false
    }

    Rectangle {
        id: status2
        x:60
        y:60
        width: 60
        height: 60
        radius: 30
        color: "grey"
        property bool gol: false
    }

    Rectangle {
        id: status3
        x:120
        y:60
        width: 60
        height: 60
        radius: 30
        color: "grey"
        property bool gol: false
    }

    Rectangle {
        id: status4
        x:180
        y:60
        width: 60
        height: 60
        radius: 30
        color: "grey"
        property bool gol: false
    }

    Rectangle {
        id: status5
        x:240
        y:60
        width: 60
        height: 60
        radius: 30
        color: "grey"
        property bool gol: false
    }

    states: [
        State {
            name: "placar0"
        },
        State {
            name: "placar1"
            PropertyChanges {
                target: status1
                color: status1.gol ? "green" : "red"
            }
        },
        State {
            name: "placar2"
            PropertyChanges {
                target: status1
                color: status1.color
            }
            PropertyChanges {
                target: status2
                color: status2.gol ? "green" : "red"
            }

        },
        State {
            name: "placar3"
            PropertyChanges {
                target: status1
                color: status1.color
            }
            PropertyChanges {
                target: status2
                color: status2.color
            }
            PropertyChanges {
                target: status3
                color: status3.gol ? "green" : "red"

            }
        },
        State {
            name: "placar4"
            PropertyChanges {
                target: status1
                color: status1.color
            }
            PropertyChanges {
                target: status2
                color: status2.color
            }
            PropertyChanges {
                target: status3
                color: status3.color
            }
            PropertyChanges {
                target: status4
                color: status4.gol ? "green" : "red"

            }
        },
        State {
            name: "placar5"
            PropertyChanges {
                target: status1
                color: status1.color
            }
            PropertyChanges {
                target: status2
                color: status2.color
            }
            PropertyChanges {
                target: status3
                color: status3.color
            }
            PropertyChanges {
                target: status4
                color: status4.color
            }
            PropertyChanges {
                target: status5
                color: status5.gol ? "green" : "red"

            }
        }
    ]

    function atualizacao(gol) {
        console.log("gol: " + gol)
        if(gol){
            placar.golos_marcados++
            console.log("golos_marcados: " + placar.golos_marcados)
        }else{
            placar.golos_falhados++
            console.log("golos_falhados: " + placar.golos_falhados)
        }
        if (placar.state == "placar0") {
            placar.state = "placar1"
            status1.gol = gol
        }else if (placar.state == "placar1") {
            placar.state = "placar2"
            status2.gol = gol
        }else if (placar.state == "placar2") {
            placar.state = "placar3"
            status3.gol = gol
        } else if (placar.state == "placar3") {
            placar.state = "placar4"
            status4.gol = gol
        } else if (placar.state == "placar4") {
            placar.state = "placar5"
            status5.gol = gol
        }
    }

    function incrementaPenaltisMarcados() {
        placar.penaltisMarcados++
    }

    function reiniciar(){
        placar.state = "placar0"
        placar.texto = "Jogador"
        placar.golos_marcados = 0
        placar.golos_falhados = 0
        placar.penaltisMarcados = 0
        status1.color = "grey"
        status1.gol = false
        status2.color = "grey"
        status2.gol = false
        status3.color = "grey"
        status3.gol = false
        status4.color = "grey"
        status4.gol = false
        status5.color = "grey"
        status5.gol = false
    }

    onPenaltisMarcadosChanged: {
        if (placar.penaltisMarcados < 5) {
            campo.novoPenalty()
            computador_placar.atualizacao(Math.ceil((Math.random()*2)) > 1 ? true : false)
        } else {
            computador_placar.atualizacao(Math.ceil((Math.random()*2)) > 1 ? true : false)
            if (jogador_placar.golos_marcados > computador_placar.golos_marcados){
                sair.texto = "Venceste!"
            } else if (jogador_placar.golos_marcados < computador_placar.golos_marcados){
                sair.texto = "Perdeste!"
            } else {
                sair.texto = "Empataste!"
            }
            campo.novoPenalty()
            campo.state = "ResultadoFinal"
        }
    }
}
