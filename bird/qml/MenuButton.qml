//Menu bottom


import QtQuick 2.0
import Felgo 3.0
import".."
// gets used for the Play button in MainScene and for the Continue button in GameOverScene
Image {
  id: button

  // width & height must get set from outside, these are the default values!
  width: 140
  height: 30
  source: "../assets/button.png"



  property alias text: buttonText.text
  property alias textColor: buttonText.color
  property alias textSize: buttonText.font.pixelSize
  property alias textItem: buttonText
  property alias font: buttonText.font

  signal clicked

  Text {
    id: buttonText
    anchors.centerIn: parent
    font.pixelSize: 20
    color: "#f5b68a"

    font.family: fontHUD.name
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    onClicked: {
      button.scale = 1.0
      button.clicked()
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
