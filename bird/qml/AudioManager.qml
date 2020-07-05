//Music mangement


import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.0
import"scene"
Item {
  id: audioManager

  // Use Sound IDs to play Sounds e.g. audioManager.play(audioManager.idBADCORN)
  property int idBack: 11
  property int idEndless: 22
  property int idCom: 33
  property int idMenuclick: 44
  property int idCoin: 55
  property int idBadcorn:66


  property bool toggleCORN



  // Use Music IDs to play Music. e.g. audioManager.playMusic(audioManager.idMusicBG)
  property int idMusicBG: 111

  function play(clipID) {
    // if settings disable do not play sounds
    if(!settings.soundEnabled)
      return

    switch(clipID) {
    case idBack:
      clipBack.play()
      break

    case idEndless:
      clipEndless.play()
      break
    case idCom:
      clipCom.play()
      break
    case idMenuclick:
      clipMenuclick.play()
      break
    case idCom:
        clipCoin.play()
        break
    case idBadcorn:
        clipBadcorn.play()
        break

    }
  }

  function playMusic(trackID) {
    // if settings disable do not play sounds
    if(!settings.musicEnabled)
      return

    switch(trackID) {
    case idMusicBG:
      music.source = "../assets/主界面.mp3"
      break
    }

    music.play()
  }

  function stopMusic() {
    music.stop()
  }

  BackgroundMusic {
    id: music
  }

  Audio {
    id: clipBack
    source: "../assets/主界面.mp3"
    volume: 1
  }
  Audio {
    id: clipEndless
    source: "../assets/model.mp3"
    volume: 1
  }
  Audio {
    id: clipCom
    source: "../assets/endless.mp3"
    volume: 1
  }
  Audio {
      id: clipMenuclick
      source: "../assets/menuclick.wav"
      volume: 1
    }
  Audio {
      id: clipCoin
      source: "../assets/SlowMo.wav"
      volume: 1
    }
  Audio{
  id:clipBadcorn
  source: "../assets/tick.wav"
  volume: 1}


  Component.onCompleted: {
    playMusic(idMusicBG)
  }
}
