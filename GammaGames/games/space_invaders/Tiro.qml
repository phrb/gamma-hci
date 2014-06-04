import QtQuick 2.0

Rectangle{
    id: tiro
    z: 0
    width: 10
    height: 10
    color: "transparent"
    property variant aliens:  null
    Image{
        height: 10
        width: 10
        source: "imagens/shot.png"
    }
    SequentialAnimation on y {
        id: yAnim
        running: true
        NumberAnimation { from: ship.y; to: -50; duration: 500; /*easing.type: Easing.InOutQuad*/ }
    }

    onXChanged: {
        for(var i = 0; i < tiro.aliens.length; i++){
            if (!tiro.aliens[i].dead){
                if(tiro.x <= tiro.aliens[i].x + tiro.aliens[i].width && tiro.aliens[i].x <= tiro.x + tiro.width
                        && tiro.y <= tiro.aliens[i].y + tiro.aliens[i].height && tiro.aliens[i].y <= tiro.y + tiro.height){
                    tiro.destroy()
                    tiro.aliens[i].death()
                }
            }
        }
    }
    onYChanged: {
        for(var i = 0; i < tiro.aliens.length; i++){
            if (!tiro.aliens[i].dead){
                if(tiro.x <= tiro.aliens[i].x + tiro.aliens[i].width && tiro.aliens[i].x <= tiro.x + tiro.width
                        && tiro.y <= tiro.aliens[i].y + tiro.aliens[i].height && tiro.aliens[i].y <= tiro.y + tiro.height){
                    tiro.destroy()
                    tiro.aliens[i].death()
                }
            }
        }
    }
}
