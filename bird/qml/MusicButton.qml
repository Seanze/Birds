//Music botton


import QtQuick 2.0
import Felgo 3.0
import".."
Item {

    id: button
    width: 40
    height: 34

    Image {
        source: "../assets/button.png"
        width: parent.width
        height: parent.height
    }
    Image {
      source: "../assets/music_on.png"
      width: 20
      height: 20
      visible: settings.musicEnabled
      anchors.centerIn: parent
    }

    Image {
      source: "../assets/music_off.png"
      width: 20
      height: 20
      visible: !settings.musicEnabled
      anchors.centerIn: parent
    }

    MouseArea {
      anchors.fill: parent

      onClicked: {
        button.scale = 1.0
        audioManager.play(audioManager.idBack)
        settings.musicEnabled = !settings.musicEnabled
      }
      onPressed: {
        button.scale = 0.85
      }
      onReleased: {
        button.scale = 1.0
      }
      onCanceled: {
        button.scale = 1.0
      }
    }

}
