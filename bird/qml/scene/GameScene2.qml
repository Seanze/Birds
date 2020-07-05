//Normal mode game scene


import QtQuick 2.0
import Felgo 3.0
import"../entity"
import".."
// EMPTY SCENE
SceneBase {
    property int pipevelocity: 0
    property int tpipeh: 0
    id:gamescene2
    width: 960
    height: 640
    sceneAlignmentY: "bottom"
    property string activeModelFileName
    property variant activelModel
    property int score: 0
    property string gameState: "wait"

    AudioManager{
    id:audioManager
    }
    ParallaxScrollingBackground{
    id:back
    anchors.fill: parent
    sourceImage: "../../assets/background2.png"
    mirrorSecondImage: false
    movementVelocity: Qt.point(-120,0)
    }

    Text {
      text: gamescene2.score
      color: "red"
      anchors.horizontalCenter: gamescene2.horizontalCenter
      y: 30
      font.pixelSize: 30
      z:2
    }
    MenuButton{
        z:2
    text: qsTr("Pause Game")
    anchors.left: gamescene2.gameWindowAnchorItem.left
    anchors.rightMargin: 10
    anchors.top: gamescene2.gameWindowAnchorItem.top
    anchors.topMargin:10
    onClicked: {
        gameWindow.state="pa2"
         audioManager.play(audioManager.idMenuclick)
        }
    }
    MenuButton{
        z:2
    text: qsTr("Back To Menu")
    anchors.right:gamescene2.gameWindowAnchorItem.right
    anchors.rightMargin: 10
    anchors.top: gamescene2.gameWindowAnchorItem.top
    anchors.topMargin:10
    onClicked: {
    backButtonPressed()
         audioManager.play(audioManager.idMenuclick)
        }
    }
    Pipe {
      id: pipe1
      x: 480
       y:200+Math.random()*200
    }
    Pipe{
    id:pipe2
    x:720
    y:200+Math.random()*200
    }
    Pipe{
    id:pipe3
    x:960
    y:200+Math.random()*200
    }



    Player{
    id: player
    x:200
    y:320
    }
    Ground2{
        anchors.horizontalCenter: gamescene2.horizontalCenter
        anchors.bottom: gamescene2.gameWindowAnchorItem.bottom
    }
    Groundtop{
        anchors.horizontalCenter: gamescene2.horizontalCenter
        anchors.bottom: gamescene2.gameWindowAnchorItem.top
    }


    MouseArea {
        anchors.fill: gamescene2.gameWindowAnchorItem
           onPressed: {
             if(gamescene2.gameState === "wait") {
               gamescene2.startGame()
               player.push()
             } else if(gamescene2.gameState === "play") {
               player.push()
                gamescene2.leve()
             }else if(gamescene2.gameState === "gameOver") {
                 //   gamescene2.stopGame()
               }
           }
      }
    function startGame() {
       gamescene2.gameState = "play"
        gamescene2.score = 0
        player.x = 200
        player.y = 320
        pipevelocity=0
        tpipeh=0

     }
    function stopGame() {

              gameWindow.state="gameover"
               gamescene2.resetGame()
    }
    function resetGame() {
      gamescene2.gameState = "wait"
      gamescene2.score = 0
      pipe1.x = 480
      pipe1.y = 200+Math.random()*200
      pipe2.x=720
      pipe2.y=200+Math.random()*200
      player.x = 200
      player.y = 320
      pipevelocity=0
      tpipeh=0
    }
    function leve(){//Increasing difficulty
        if(gamescene2.score===10){
        pipevelocity=pipevelocity-20
        tpipeh=tpipeh-5
        }else if(gamescene2.score===15){
            pipevelocity=pipevelocity-10
             tpipeh=tpipeh-5
        }else if(gamescene2.score===20){
            pipevelocity=pipevelocity-10
             tpipeh=tpipeh-5
        }else if(gamescene2.score===30){
            pipevelocity=pipevelocity-10
             tpipeh=tpipeh-5
        }
    }

}
