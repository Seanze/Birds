//Mode selection


import QtQuick 2.0
import Felgo 3.0
import".."
// EMPTY SCENE

SceneBase {
        id:selectModels
        signal endlessPressed
        signal commonPressed

        Image {
            id: background
            source: "../../assets/backgroud.png"
            anchors.fill: parent
        }
        AudioManager{
        id:audioManager
        }
        MenuButton{
            text: qsTr("Endless Model")
            onClicked: {
            endlessPressed()
           audioManager.play(audioManager.idMenuclick)
            }
            anchors.left: parent.Left
            textSize: 27
            width: 170 * 1.1
            height: 60 * 1.1
            y: 130
        }
        MenuButton{
            text: qsTr("Common Model")

            onClicked: {
            commonPressed()
                 audioManager.play(audioManager.idMenuclick)
            }
            anchors.right: parent.right
            textSize: 27
            width: 170 * 1.1
            height: 60 * 1.1
            y: 130
        }
        MenuButton{
        text:qsTr("Back")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        onClicked: {
        backButtonPressed()
        }
        }

}
