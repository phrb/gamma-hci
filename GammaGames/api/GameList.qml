import QtQuick 2.2

/*
  The easier way to add new games would be
  editing this list. A definitive solution would
  involve implementation of a C++ plugin to
  read from files, and a QML parser.
 */
ListModel { 
    ListElement {
        name: "Arcade";
        menuImage: "imgs/tags/arcade.png";
        gameList: [
            ListElement {
                name: "Space Invaders";
                menuImage: "../games/space_invaders/imagens/space_invaders.png";
                file: "../games/space_invaders/SpaceInvaders.qml"
            },
            ListElement {
                name: "Voltar";
                menuImage: "imgs/back.png";
                file: "";
            }
        ]
    }
    ListElement {
        name: "Esporte";
        menuImage: "imgs/tags/sports.png";
        gameList: [
            ListElement {
                name: "Chute-a-Gol";
                menuImage: "../games/chute_a_gol/imagens/soccer.png";
                file: "../games/chute_a_gol/main.qml"
            },
            ListElement {
                name: "Voltar";
                menuImage: "imgs/back.png";
                file: "";
            }
        ]
    }
    ListElement {
        name: "Favoritos";
        menuImage: "imgs/tags/favorites.png";
        gameList: [
            ListElement {
                name: "Chute-a-Gol";
                menuImage: "../games/chute_a_gol/imagens/soccer.png";
                file: "../games/chute_a_gol/main.qml"
            },
            ListElement {
                name: "Voltar";
                menuImage: "imgs/back.png";
                file: "";
            },
            ListElement {
                name: "Space Invaders";
                menuImage: "../games/space_invaders/imagens/space_invaders.png";
                file: "../games/space_invaders/SpaceInvaders.qml"
            }
        ]
    }
}
