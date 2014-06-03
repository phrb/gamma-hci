import QtQuick 2.2
import QtMultimedia 5.0

Rectangle {
    id: screen

    width: sceneLoader.width
    height: sceneLoader.height
    color: "black"
    property int rotate_time: 3

    Timer{
        id: rotateTimer
        interval: rotate_time * 1000
        running: true
        repeat: true

        onTriggered: {
            view.decrementCurrentIndex()
        }
    }
<<<<<<< HEAD
    AnimatedImage {
=======

    Timer{
        id: chooseTimer
        interval: 1500
        running: false
        repeat: false

        onTriggered: {
            sceneLoader.source = view.currentItem.gameFile
        }
    }

    SoundEffect {
        id: playSound
        source: "menu.wav"
    }

    Image {
>>>>>>> fce7ce9d2600041d365e8217c208cc9f5f5c3261
        id: preview
        z: 1000
        signal changeGame(string previewSource)
        onChangeGame: {
            source = previewSource
            playing = true
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
        Keys.onEscapePressed: Qt.quit()
        Keys.onSpacePressed: {
            playSound.play()
            focus = false
            rotateTimer.stop()
            anim.start()
        }

        ParallelAnimation {
            id: anim
            running: false
            NumberAnimation { target: preview; property: "width"; to: screen.width; duration: 1000 }
            NumberAnimation { target: preview; property: "height"; to: screen.height; duration: 1000 }
            AnchorAnimation { duration: 1000 }
            NumberAnimation { target: preview; property: "y"; to: 0; duration: 1000 }

            onStopped: {
                sceneLoader.lastChosenIndex = view.currentIndex
                sceneLoader.source = view.currentItem.gameFile
            }
        }

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
        currentIndex: sceneLoader.lastChosenIndex

        model: GameList {}
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

            AnimatedImage {
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
