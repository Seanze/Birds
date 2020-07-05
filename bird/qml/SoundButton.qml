//Game click sound effect

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
    source: "../assets/sound_on.png"
    width: 20
    height: 20
    visible: settings.soundEnabled
    anchors.centerIn: parent
  }

  Image {
    source: "../assets/sound_off.png"
    width: 20
    height: 20
    visible: !settings.soundEnabled
    anchors.centerIn: parent
  }
  AudioManager{
  id:audioManager}

  MouseArea {
    anchors.fill: parent

    onClicked: {
      button.scale = 1.0
      settings.soundEnabled = !settings.soundEnabled
      audioManager.play(audioManager.idMenuclick)
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
