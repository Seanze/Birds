import QtQuick 2.0
import Felgo 3.0
import".."
// EMPTY SCENE

SceneBase {

    Image {
        source: "../../assets/gameOverText.png"
        anchors.fill: parent

    }
    AudioManager{
    id:audioManager
    }
    MenuButton{
    text: qsTr("Back to menu")
    anchors.right: gameScene1.gameWindowAnchorItem.right
    anchors.rightMargin: 10
    anchors.top: gameScene1.gameWindowAnchorItem.top
    anchors.topMargin:10
    onClicked: {
        backButtonPressed()
        audioManager.play(audioManager.idMenuclick)
    }
    }

}
