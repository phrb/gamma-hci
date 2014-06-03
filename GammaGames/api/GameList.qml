import QtQuick 2.2

/*
  The easier way to add new games would be
  editing this list. A definitive solution would
  involve implementation of a C++ plugin to
  read from files, and a QML parser.
 */
ListModel {
    ListElement { name: "Space Invaders";   menuImage: "../games/space_invaders/imagens/CoolSI.gif";    previewImage: "../games/space_invaders/imagens/space-invaders-o.gif";   file: "../games/space_invaders/SpaceInvaders.qml" }
    ListElement { name: "Gol-a-Gol";        menuImage: "../games/chute_a_gol/imagens/Goleiro.jpg";      previewImage: "../games/chute_a_gol/imagens/Goleiro.jpg";               file: "../games/chute_a_gol/main.qml" }
    ListElement { name: "Space Invaders";   menuImage: "../games/space_invaders/imagens/CoolSI.gif";    previewImage: "../games/space_invaders/imagens/space-invaders-o.gif";   file: "../games/space_invaders/SpaceInvaders.qml" }
    ListElement { name: "Gol-a-Gol";        menuImage: "../games/chute_a_gol/imagens/Goleiro.jpg";      previewImage: "../games/chute_a_gol/imagens/Goleiro.jpg";               file: "../games/chute_a_gol/main.qml" }
    ListElement { name: "Space Invaders";   menuImage: "../games/space_invaders/imagens/CoolSI.gif";    previewImage: "../games/space_invaders/imagens/space-invaders-o.gif";   file: "../games/space_invaders/SpaceInvaders.qml" }
    ListElement { name: "Gol-a-Gol";        menuImage: "../games/chute_a_gol/imagens/Goleiro.jpg";      previewImage: "../games/chute_a_gol/imagens/Goleiro.jpg";               file: "./games/chute_a_gol/main.qml" }
}
