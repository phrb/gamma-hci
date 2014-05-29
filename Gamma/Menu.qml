import QtQuick 2.2

Rectangle {
    id: screen

    width: sceneLoader.width
    height: sceneLoader.height
    color: "black"

    Image {
        id: preview

        signal changeGame(string previewSource)
        onChangeGame: source = previewSource
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
        Keys.onEscapePressed: Qt.quit()
        Keys.onSpacePressed: { sceneLoader.source = currentItem.gameFile }

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
        currentIndex: 0

        model: GameModel {}
        delegate: Rectangle {
            id: game
            objectName: name
            width: screen.width/10.0 + selectionBorder
            height: screen.height/10.0 + selectionBorder
            scale: 4*y/view.y < 0.75 ? 0.75 : 4*y/view.y
            color: "transparent"
            z: y/screen.height
            smooth: true
            opacity: scale / 2.0 < 0.2 ? 0.2 : scale / 2.0

            property int selectionBorder: 4
            property string previewSource: previewImage
            property string gameFile: file

            Image {
                width: parent.width - parent.selectionBorder
                height: parent.height - parent.selectionBorder
                source: menuImage
                anchors.centerIn: parent
            }

            states: [
                State {
                    name: "SELECTED"
                    PropertyChanges { target: game; border.color: "red"; border.width : selectionBorder}
                },
                State {
                    name: "UNSELECTED"
                    PropertyChanges { target: game; border.color: "black"; border.width : selectionBorder}
                }
            ]

            state: PathView.isCurrentItem ? "SELECTED" : "UNSELECTED"
            onStateChanged: if (state === "SELECTED") preview.changeGame(game.previewSource)
        }

    }
}
