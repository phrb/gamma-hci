import QtQuick 2.2

Rectangle {
    id: screen
    width: 1280
    height: 720
    color: "black"

    Image {
        id: preview
        signal changeGame(string previewSource)
        onChangeGame: {
            source = previewSource
        }
        width: screen.width * 0.4
        height: screen.height * 0.4
        y: screen.height * 0.075
        anchors.horizontalCenter: screen.horizontalCenter
    }



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
        height: parent.height * 0.4
        y: parent.height * 0.5
        anchors.horizontalCenter: parent.horizontalCenter

        model: GameModel {}
        delegate: Rectangle {
            id: game
            objectName: name
            width: screen.width/10.0 + selectionBorder
            height: screen.height/10.0 + selectionBorder
            scale: 4*y/view.y < 0.75 ? 0.75 : 4*y/view.y
            color:"transparent"
            z: y
            smooth: true
            opacity: scale / 2.0 < 0.2 ? 0.2 : scale / 2.0
            property int selectionBorder: 4
            property string previewSource: imgSource2

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
                },
                State {
                    name: "UNSELECTED"
                    PropertyChanges { target: game; border.color: "black"; border.width : 0}
                }
            ]

            state: game.PathView.isCurrentItem ? "SELECTED" : "UNSELECTED"
            onStateChanged: if (state === "SELECTED") preview.changeGame(game.previewSource)
        }

    }
}
