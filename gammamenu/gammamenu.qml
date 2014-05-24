import QtQuick 2.2

Rectangle {
    id: screen
    width: 1280
    height: 720
    color: "black"

    PathView {
        id: view

        focus: true
        Keys.onLeftPressed: decrementCurrentIndex()
        Keys.onRightPressed: incrementCurrentIndex()
        Keys.onSpacePressed: console.log("You chose: " + currentItem.objectName)

        path: Ellipse {
            width: view.width
            height: view.height
        }

        preferredHighlightBegin: 0
        preferredHighlightEnd: 0
        highlightRangeMode: PathView.StrictlyEnforceRange

        width: parent.width * 0.9
        height: parent.height * 0.8
        anchors.horizontalCenter: parent.horizontalCenter

        model: GameModel {}
        delegate: Rectangle {
            id: game
            objectName: name
            width: screen.width/10.0 + selectionBorder
            height: screen.height/10.0 + selectionBorder
            scale: 4.0 * y / parent.height
            color:"transparent"
            z: y
            smooth: true
            opacity: scale / 2.0
            property int selectionBorder: 4

            Image {
                id: img
                width: parent.width - parent.selectionBorder
                height: parent.height - parent.selectionBorder
                source: imgSource
                anchors.centerIn: parent
            }

            states: [
                State {
                    name: "SELECTED"
                    PropertyChanges { target: game; border.color: "red"; border.width : selectionBorder}
                    StateChangeScript { name: "myScript"; script: console.log(game.objectName); }
                },
                State {
                    name: "UNSELECTED"
                    PropertyChanges { target: game; border.color: "black"; border.width : 0}
                }
            ]

            state: (parent.currentItem === this || (parent.currentItem === null && index === 0)) ? "SELECTED" : "UNSELECTED"
        }
    }
}
