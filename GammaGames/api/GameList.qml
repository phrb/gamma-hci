import QtQuick 2.2

/*
  The easier way to add new games would be
  editing this list. A definitive solution would
  involve implementation of a C++ plugin to
  read from files, and a QML parser.
 */
ListModel {
    ListElement { name: "Pule!";           menuImage: "imgs/jump.png";   previewImage: "imgs/jump.png";      file: "../games/chute_a_gol/main.qml" }
    ListElement { name: "Gol-a-Gol";       menuImage: "imgs/goal.png";   previewImage: "imgs/goal.png";      file: "Game0.qml" }
    ListElement { name: "Mate o Dragão";   menuImage: "imgs/dragon.png"; previewImage: "imgs/dragon.png";    file: "Game0.qml" }
    ListElement { name: "Space Invaders";  menuImage: "imgs/space.png";  previewImage: "imgs/space.png";     file: "Game0.qml" }
    ListElement { name: "Pegue Todos";     menuImage: "imgs/grab.png";   previewImage: "imgs/grab.png";      file: "Game0.qml" }
    ListElement { name: "Atacar!";         menuImage: "imgs/attack.png"; previewImage: "imgs/attack.png";    file: "Game0.qml" }
}
