//Menu scene


import QtQuick 2.0
import Felgo 3.0
import".."

// EMPTY SCENE

SceneBase {

    id:menuScene

    signal selectModelsPressed

    Image {
        source: "../../assets/backgroud.png"
        anchors.fill: parent

    }
    PhysicsWorld {
       debugDrawVisible: false// set this to false to hide the physics overlay
       gravity.y: gamescene2.gameState !== "wait" ||gameScence1.gameState!=="wait" ? 10 : 0

     }
    AudioManager{
    id:audioManager
    }
    Image {
      id: gameNetworkSign
      source: "../../assets/sign.png"
      anchors.horizontalCenter: parent.horizontalCenter
      width: 150
      height: 120
      mirror: true

      rotation: signRotation
      Item {
        y:82
        anchors.horizontalCenter: parent.horizontalCenter
        width:  highscoreText.width+scoreImage.width+highscoreTextScore.width
        rotation: 2

        MenuText {
          id: highscoreText
          text: qsTr("Highscore:")
          font.pixelSize: 20
        }
        Image {
          id: scoreImage
          source: "../../assets/gamecenter.png"
          y: 1
          width: 20
          height: 20
          anchors.left: highscoreText.right
          anchors.leftMargin: 1
        }

        MenuText {
          id: highscoreTextScore
          text: ""+ maximumHighscore
          font.pixelSize: 20
          anchors.left: scoreImage.right
          anchors.leftMargin: 5
        }
      }
      MouseArea {
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height/2
        onClicked: {
          parent.scale = 1.0
          audioManager.play(audioManager.idMenuclick)
          gameWindow.state="felgoscene"
          gameNetwork.showLeaderboard()
        }

        onPressed: {
          parent.scale = 0.85
        }
        onReleased: {
          parent.scale = 1.0
        }
        onCanceled: {
          parent.scale = 1.0
        }
      }
    }

    MenuButton{
        text: qsTr("Play")
        onClicked: {
            selectModelsPressed()
             audioManager.play(audioManager.idMenuclick)
        }

        anchors.horizontalCenter: parent.horizontalCenter
        textSize: 27
        width: 170 * 1.1
        height: 60 * 1.1
        y: 130

        rotation: 4
    }
    MusicButton {
    }

    SoundButton {
      y:50
    }
    MenuButton{
        text: qsTr("Exit")


        anchors.horizontalCenter: parent.horizontalCenter
        textSize: 27
        width: 170 * 1.1
        height: 60 * 1.1
        y: 130+90

        rotation: -6
        onClicked: {
            Qt.quit()
             audioManager.play(audioManager.idMenuclick)
        }
    }



}
