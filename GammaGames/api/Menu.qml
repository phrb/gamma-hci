import QtQuick 2.2
import QtMultimedia 5.0

Rectangle {
    id: screen

    width: sceneLoader.width
    height: sceneLoader.height
    color: "black"

    property int rotate_time: 2000
    property string selectSound: "menu.wav"

    states: [
        State {
            name: "game"
            PropertyChanges { target: carousel_tag; opacity: 0; z: 0; scale: 0.01 }
            PropertyChanges { target: carousel_game; opacity: 1; z: 10; scale: 1.0 }
            onCompleted: {
                carousel_game.focus = true;
                rotateTimerGame.start();
            }
        },
        State {
            name: "tag"
            PropertyChanges { target: carousel_tag; opacity: 1; z: 10; scale: 1.0 }
            PropertyChanges { target: carousel_game; opacity: 0; z: 0; scale: 0.01 }
            onCompleted: {
                carousel_tag.focus = true;
                rotateTimerTag.start();
            }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation {
                duration: 1000;
                properties: "scale,opacity"
            }
        }
    ]

    Timer {
        id: rotateTimerTag
        interval: rotate_time
        running: true
        repeat: true

        onTriggered: {
            carousel_tag.decrementCurrentIndex()
        }
    }

    Timer {
        id: rotateTimerGame
        interval: rotate_time
        running: false
        repeat: true

        onTriggered: {
            carousel_game.decrementCurrentIndex()
        }
    }


    SoundEffect {
        id: playSound
        source: selectSound
    }

    AnimatedImage {
        id: preview
        opacity: 0

        states: [
            State {
                name: "expanded"
                PropertyChanges { target: preview; opacity: 1; x: (width*scale-width)/2.0; y: (height*scale-height)/2.0; z: 100; width: screen.width/scale; height: screen.height/scale }
                onCompleted: {
                    sceneLoader.source = carousel_game.currentItem.gameFile
                }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation {
                    duration: 1250;
                    properties: "x,y,height,width"
                }
            }
        ]
    }

    PathView {
        id: carousel_tag
        width: screen.width * 0.8
        height: screen.height * 0.4
        anchors.centerIn: screen
        focus: true

        Keys.onEscapePressed: Qt.quit()
        Keys.onSpacePressed: {
            playSound.play();
            focus = false;
            rotateTimerTag.stop();
            sceneLoader.lastChosenIndex = currentIndex;
            screen.state = "game";
            carousel_game.model = currentItem.games;
        }

        path: Ellipse {
            width: carousel_tag.width
            height: carousel_tag.height
        }

        preferredHighlightBegin: 0
        preferredHighlightEnd: 0
        highlightRangeMode: PathView.StrictlyEnforceRange
        currentIndex: sceneLoader.lastChosenIndex

        model: GameList {}
        delegate: tagDelegate
    }

    PathView {
        id: carousel_game
        width: screen.width * 0.8
        height: screen.height * 0.4
        scale: 0.01
        anchors.centerIn: screen
        focus: false

        Keys.onEscapePressed: Qt.quit()
        Keys.onSpacePressed: {
            playSound.play();
            focus = false;
            rotateTimerGame.stop();

            if (currentItem.objectName === "Voltar" && currentItem.file === "") {
                screen.state = "tag";
            }
            else {
                preview.source = currentItem.image;
                preview.width = currentItem.width;
                preview.height = currentItem.height;
                preview.scale = currentItem.scale;
                preview.y = carousel_tag.y + currentItem.y;
                preview.x = carousel_tag.x + currentItem.x;
                preview.state = "expanded";
            }
        }

        path: Ellipse {
            width: carousel_game.width
            height: carousel_game.height
        }

        preferredHighlightBegin: 0
        preferredHighlightEnd: 0
        highlightRangeMode: PathView.StrictlyEnforceRange

        delegate: gameDelegate
    }

    Component {
        id: tagDelegate

        Item {
            id: wrapperTag
            objectName: name
            width: screen.width/10.0 + selectionBorder
            height: screen.height/10.0 + selectionBorder
            visible: PathView.onPath
            scale: PathView.itemScale
            z: PathView.itemZ

            property int selectionBorder: 4
            property var games: gameList
            property bool currentItem: PathView.isCurrentItem
            property bool moving: PathView.view.moving
            property double opacityValue: PathView.itemOpacity

            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.width: parent.selectionBorder
                border.color: parent.currentItem ? "red" : "black"
            }

            AnimatedImage {
                width: parent.width - parent.selectionBorder
                height: parent.height - parent.selectionBorder
                source: menuImage
                anchors.centerIn: parent
                smooth: moving
                opacity: opacityValue
            }
        }
    }

    Component {
        id: gameDelegate

        Item {
            id: wrapperGame
            objectName: name
            width: screen.width/10.0 + selectionBorder
            height: screen.height/10.0 + selectionBorder
            visible: PathView.onPath
            scale: PathView.itemScale
            z: PathView.itemZ

            property int selectionBorder: 4
            property string gameFile: file
            property string image: menuImage
            property bool currentItem: PathView.isCurrentItem
            property bool moving: PathView.view.moving
            property double opacityValue: PathView.itemOpacity

            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.width: parent.selectionBorder
                border.color: parent.currentItem ? "red" : "black"
            }

            AnimatedImage {
                width: parent.width - parent.selectionBorder
                height: parent.height - parent.selectionBorder
                source: image
                anchors.centerIn: parent
                smooth: moving
                opacity: opacityValue
            }
        }
    }
}

