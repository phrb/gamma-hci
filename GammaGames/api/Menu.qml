import QtQuick 2.2
import QtMultimedia 5.0

Rectangle {
    id: screen

    width: sceneLoader.width
    height: sceneLoader.height
    color: "black"
    state: sceneLoader.lastChosenGameIndex === -1 ? "tag" : "game";

    property int rotate_time: 2000
    property string selectSound: "menu.wav"

    GameList {
        id: gammaGameList
    }

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
                sceneLoader.lastChosenGameIndex = -1;
                carousel_tag.focus = true;
                rotateTimerTag.start();
            }
        }
    ]

    transitions: [
        Transition {
            from: "tag"
            to: "game"
            SequentialAnimation {
                NumberAnimation {
                    target: carousel_tag
                    duration: 750
                    properties: "scale,opacity"
                }
                NumberAnimation {
                    target: carousel_game
                    duration: 750
                    properties: "scale,opacity"
                }
            }
        },
        Transition {
            from: "game"
            to: "tag"
            SequentialAnimation {
                NumberAnimation {
                    target: carousel_game
                    duration: 750
                    properties: "scale,opacity"
                }
                NumberAnimation {
                    target: carousel_tag
                    duration: 750
                    properties: "scale,opacity"
                }
            }
        }
    ]

    Timer {
        id: rotateTimerTag
        interval: rotate_time
        running: screen.state === "tag"
        repeat: true

        onTriggered: {
            carousel_tag.decrementCurrentIndex()
        }
    }

    Timer {
        id: rotateTimerGame
        interval: rotate_time
        running: screen.state === "game"
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
        z: 0

        states: [
            State {
                name: "expanded"
                PropertyChanges { target: preview; opacity: 1; x: (width*scale-width)/2.0; y: (height*scale-height)/2.0; z: 100; width: screen.width/scale; height: screen.height/scale }
                onCompleted: {
                    sceneLoader.lastChosenGameIndex = carousel_game.currentIndex;
                    sceneLoader.source = carousel_game.currentItem.gameFile
                }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation {
                    duration: 1000;
                    properties: "x,y,height,width"
                }
            }
        ]
    }

    PathView {
        id: carousel_tag
        width: screen.width * 0.8
        height: screen.height * 0.4
        scale: screen.state === "tag" ? 1.0 : 0.01
        opacity: screen.state === "tag" ? 1 : 0
        z: screen.state === "tag" ? 10 : 0
        anchors.centerIn: screen
        focus: screen.state === "tag"

        Keys.onEscapePressed: Qt.quit()
        Keys.onSpacePressed: {
            playSound.play();
            focus = false;
            rotateTimerTag.stop();
            sceneLoader.lastChosenTagIndex = currentIndex;
            screen.state = "game";
            carousel_game.currentIndex = 0;
            carousel_game.model = currentItem.games;
        }

        path: Ellipse {
            width: carousel_tag.width
            height: carousel_tag.height
        }

        preferredHighlightBegin: 0
        preferredHighlightEnd: 0
        highlightRangeMode: PathView.StrictlyEnforceRange
        currentIndex: sceneLoader.lastChosenTagIndex

        model: gammaGameList
        delegate: tagDelegate
    }

    PathView {
        id: carousel_game
        width: screen.width * 0.8
        height: screen.height * 0.4
        scale: screen.state === "game" ? 1.0 : 0.01
        opacity: screen.state === "game" ? 1 : 0
        z: screen.state === "game" ? 10 : 0
        anchors.centerIn: screen
        focus: screen.state === "game"

        Keys.onEscapePressed: Qt.quit()
        Keys.onSpacePressed: {
            playSound.play();
            focus = false;
            rotateTimerGame.stop();

            if (currentItem.objectName === "Voltar" && currentItem.file === undefined) {
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
        currentIndex: sceneLoader.lastChosenGameIndex === -1 ? 0 : sceneLoader.lastChosenGameIndex

        model: sceneLoader.lastChosenGameIndex === -1 ? [] : gammaGameList.get(sceneLoader.lastChosenTagIndex).gameList
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

