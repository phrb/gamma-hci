import QtQuick 2.2
import QtQuick.Window 2.1

Loader {
    id: sceneLoader
    width: Screen.width*0.8
    height: Screen.height*0.8
    focus: true
    source: menuSource
    property string menuSource: "api/Menu.qml"
}
