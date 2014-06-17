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

    SoundEffect {
        id: playSound
        source: "menu.wav"
        volume: 0.3
    states: [
        State {
            name: "game"
            PropertyChanges { target: carousel_tag; opacity: 0; z: 0; scale: 0 }
            PropertyChanges { target: carousel_game; opacity: 1; z: 10; scale: 1 }
            onCompleted: {
                carousel_game.focus = true;
                rotateTimer.carousel = carousel_game;
                rotateTimer.start();
            }
        },
        State {
            name: "tag"
            PropertyChanges { target: carousel_tag; opacity: 1; z: 10; scale: 1 }
            PropertyChanges { target: carousel_game; opacity: 0; z: 0; scale: 0 }
            onCompleted: {
                sceneLoader.lastChosenGameIndex = -1;
                carousel_tag.focus = true;
                rotateTimer.carousel = carousel_tag;
                rotateTimer.start();
            }
        }
    ]

    transitions: [
        Transition {
            from: "tag"
            to: "game"
            reversible: true
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
        }
    ]

    Timer {
        id: rotateTimer
        interval: rotate_time
        running: false
        repeat: true
        property PathView carousel

        onTriggered: {
            carousel.decrementCurrentIndex()
        }
    }

    SoundEffect {
        id: playSound
        source: selectSound
        volume: 0.3
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
        scale: 0
        opacity: 0
        z: 0
        focus: false
        anchors.centerIn: screen

        Keys.onEscapePressed: Qt.quit()
        Keys.onSpacePressed: {
            playSound.play();
            focus = false;
            rotateTimer.stop();
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

        Component.onCompleted: {
            if (screen.state === "tag") {
                scale =  1
                opacity = 1
                z: 10
                focus: true
            }
        }
    }

    PathView {
        id: carousel_game
        width: screen.width * 0.8
        height: screen.height * 0.4
        scale: 0
        opacity: 0
        z: 0
        focus: false
        anchors.centerIn: screen

        Keys.onEscapePressed: Qt.quit()
        Keys.onSpacePressed: {
            playSound.play();
            focus = false;
            rotateTimer.stop();

        SequentialAnimation {
            id: anim
            running: false

            PropertyAnimation {
                target: view.currentItem
                properties: "scale"
                to: 15.0
                duration: 500
            }

            onStopped: {
                sceneLoader.lastChosenIndex = view.currentIndex
                sceneLoader.source = view.currentItem.gameFile
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

        width: parent.width * 0.8
        height: parent.height * 0.3
        y: parent.height * 0.3
        anchors.horizontalCenter: parent.horizontalCenter
        currentIndex: sceneLoader.lastChosenIndex
        Component.onCompleted: {
            if (screen.state === "game") {
                scale =  1
                opacity = 1
                z: 10
                focus: true
            }
        }
    }

    Component {
        id: tagDelegate

        Item {
            id: wrapperTag
            objectName: name
            width: screen.width/5.0 + selectionBorder
            height: screen.height/5.0 + selectionBorder
            scale: 4*y/view.y < 0.75 ? 0.75 : 4*y/view.y
            color: "transparent"
            z: y/screen.height
            smooth: true
            opacity: scale / 2.0 < 0.2 ? 0.2 : scale / 2.0
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
                radius: 1
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

            states: [
                State {
                    name: "SELECTED"
                    PropertyChanges { target: game; border.color: "red"; border.width : selectionBorder }
                },
                State {
                    name: "UNSELECTED"
                    PropertyChanges { target: game; border.color: "black"; border.width : selectionBorder }
                }
            ]

            state: PathView.isCurrentItem ? "SELECTED" : "UNSELECTED"
            Component.onCompleted: {
                view.decrementCurrentIndex()
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
                radius: 1
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

