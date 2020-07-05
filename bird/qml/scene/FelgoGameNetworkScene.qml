import QtQuick 2.0
import Felgo 3.0
import".."
SceneBase {
  id: scene

  // needs to be accessed assigned to the FelgoGameNetwork, so it can show it
  property alias gameNetworkView: gameNetworkView

  onBackButtonPressed: {
    goBackToMenu()
  }
  AudioManager{
  id:audioManager
  }

  GameNetworkView {
    id: gameNetworkView
    anchors.fill: scene.gameWindowAnchorItem

    // this is only used temporarily, until the font issue is fixed
    onBackClicked: {
        goBackToMenu()
    }
  }

  function goBackToMenu() {
    //audioManager.play(audioManager.idMENUCLICK)
        gameWindow.state="menu"  }
}
