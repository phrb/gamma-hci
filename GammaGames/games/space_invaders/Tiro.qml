import QtQuick 2.0

Image{
    source: "imagens/shot.png"

    SequentialAnimation on y {
                id: yAnim
                running: true
                NumberAnimation { from: ship.y; to: -50; duration: 500; easing.type: Easing.InOutQuad }
            }
}
