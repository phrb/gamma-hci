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
    property bool key_pressed: false
    property int timeout_seconds: 15

    function escape_key (){
        sceneLoader.source = sceneLoader.menuSource;
    }
    function button1(){} // Does nothing in an empty game.
    function button2(){} // Does nothing in an empty game.

    width: sceneLoader.width
    height: sceneLoader.height
    color: "black"
    anchors.fill: parent
    focus: true
    Timer{
        interval: timeout_seconds * 1000; running: true;
        repeat: true;

        onTriggered: {
            if ( !key_pressed ){
                sceneLoader.source = sceneLoader.menuSource
            }
            else{
                key_pressed = false;
            }
        }
    }
    Keys.onReleased: {
        if ( !key_pressed ){
            key_pressed = true;
        }
    }
    Keys.onEscapePressed: escape_key()
    Keys.onDigit0Pressed: button1() // Digit0: Provisory bindings for Button1.
    Keys.onDigit1Pressed: button2() // Digit1: Provisory bindings for Button2.
}
