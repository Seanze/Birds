//Normal mode pause


import QtQuick 2.0
import Felgo 3.0
import".."


SceneBase {

    Text {
        text: "Pasue Game"
        color: "blue"

        anchors.centerIn: parent
    }
    Image {
        id: background
        source: "../../assets/background2.png"
    }
    AudioManager{
    id:audioManager
    }
    MenuButton{
        text: qsTr("back")
        onClicked: {
            backButtonPressed()
             audioManager.play(audioManager.idMenuclick)
        }

        anchors.horizontalCenter: parent.horizontalCenter
        textSize: 27
        width: 170 * 1.1
        height: 60 * 1.1
        y: 130

        rotation: 4
    }
    MusicButton{

    }


}
