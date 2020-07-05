//GameWindow


import Felgo 3.0
import QtQuick 2.0
import"entity"
import"scene"
import".."
GameWindow {
    id: gameWindow
    screenWidth: 960
    screenHeight: 640

 property int maximumHighscore: 0
    Rectangle{
    id:background
    color: "white"
    anchors.fill: parent
    }
    EntityManager{
    id:entityManager
    entityContainer: gameScence1

    }
    FontLoader {
      id: fontHUD
      source: "../qml/fonts/rodeo.ttf"
    }
    MenuScene{
    id:menuscene
    onSelectModelsPressed: gameWindow.state="selectModels"

    }

    SelectModelsScene{
    id:selectModels

    onEndlessPressed:  gameWindow.state="game1"
    onCommonPressed:    gameWindow.state="game2"

    onBackButtonPressed: gameWindow.state="menu"
    }
    FelgoGameNetwork {
      id: gameNetwork
      // created in the Felgo Web Dashboard
      gameId: 5
      secret: "abcdefg1234567890"
      gameNetworkView: myGameNetworkView
    }
    GameScence1{
    id:gameScence1

    onBackButtonPressed: gameWindow.state="menu"
    }
    GameScene2{
    id:gamescene2

    onBackButtonPressed: gameWindow.state="menu"
    }
    GameOverScene{
    id:gameOver

    onBackButtonPressed: gameWindow.state="menu"
    }
    PasueScene1{
    id:pasue1
  //  state: pa1
    onBackButtonPressed: gameWindow.state="game1"
    }
    PasueScene2{
    id:pasue2
    state: pa2
    onBackButtonPressed: gameWindow.state="game2"
    }
    FelgoGameNetworkScene{
    id:felgo

    state:felgoscene
    }

    state: "menu"
    activeScene: menuscene
    states:[
        State {
            name: "menu"
            PropertyChanges { target: menuscene;opacity:1 }
            PropertyChanges { target:gameWindow;activeScene:menuscene}
        },
        State {
            name: "selectModels"
            PropertyChanges {target: selectModels;opacity:1 }
            PropertyChanges { target:gameWindow;activeScene:selectModels}
        },
        State {
            name: "game1"
            PropertyChanges {target: gameScence1;opacity:1 }
            PropertyChanges { target:gameWindow;activeScene:gameScence1}
        },
        State {
            name: "game2"
            PropertyChanges {target: gamescene2;opacity:1 }
            PropertyChanges { target:gameWindow;activeScene:gamescene2}
        },
        State {
            name: "pa1"
            PropertyChanges {target: pasue1;opacity:1 }
            PropertyChanges { target:gameWindow;activeScene:pasue1}
        },
        State {
            name: "pa2"
            PropertyChanges {target: pasue2;opacity:1 }
            PropertyChanges { target:gameWindow;activeScene:pasue2}
        },
        State {
            name: "felgoscene"
            PropertyChanges {target: felgo;opacity:1 }
            PropertyChanges { target:gameWindow;activeScene:felgo}
        },
        State {
            name: "gameover"
            PropertyChanges {target: gameOver;opacity:1 }
            PropertyChanges { target:gameWindow;activeScene:gameOver}
        }



    ]
}
