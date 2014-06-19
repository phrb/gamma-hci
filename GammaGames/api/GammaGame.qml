import QtQuick 2.2

/*
  Simple class that will serve as template
  for future games, implemented by us or
  others.

  Includes a Timeout functionality,
  defaulted to 15 seconds, but can be
  changed by the developer on extension.

  Since we use only 2 buttons, we
  mapped them here and implemented
  callbacks for these button presses,
  so the developer of a new game has
  simply to override button1() and
  button2() in her code.
 */
Rectangle {
    property int timeout_seconds: 40
    property int zTimeout: 999999

    Rectangle {
        id: timeout_bar
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: 20
        opacity: 0
        z: zTimeout
        color: "red"

        function reset() {
            timeout_timer.ticks = 0;
            timeout_bar.opacity = 0;
            timeout_bar.width = parent.width
        }
    }

    MouseArea {
        anchors.fill: parent
        z: zTimeout + 1
        onPressed: {
            button1();
            timeout_bar.reset();
        }
    }

    function escape_key (){
        sceneLoader.source = "../" + sceneLoader.menuSource;
    }
    function button1(){} // Does nothing in an empty game.
    function button2(){} // Does nothing in an empty game.

    width: sceneLoader.width
    height: sceneLoader.height
    color: "black"
    anchors.fill: parent
    focus: true

    Timer {
        id: timeout_timer
        interval: timeout_seconds * 1000 / 100; running: true;
        repeat: true;
        property int ticks: 0

        onTriggered: {
            ticks += 1;
            timeout_bar.width = timeout_bar.width - (parent.width/100);
            timeout_bar.opacity = timeout_bar.opacity + 0.015;
            if (timeout_bar.opacity > 1){
                timeout_bar.opacity = 1;
            }
            if (timeout_bar.width < 0){
                timeout_bar.width = 0;
            }
            if ( ticks > 100 ){
                sceneLoader.source = "../" + sceneLoader.menuSource
            }
        }
    }

    Keys.onEscapePressed: escape_key()
    Keys.onSpacePressed: {
        button1();
        timeout_bar.reset();
    }
    Keys.onDigit1Pressed: {
        button2();
        timeout_bar.reset();
    }
}
