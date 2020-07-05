//Gold bonus


import QtQuick 2.0
import Felgo 3.0
import"../scene"
import".."
EntityBase {
    id: gold

    width: 26
    height: 26
    entityType: "gold"

    Image {
         id: coin
         source: "../../assets/coin.png"
      //   anchors.top: gold.bottom
        // anchors.horizontalCenter: gold.horizontalCenter
       }
    AudioManager{
    id:audioManager
    }
    BoxCollider {
          anchors.fill: gold
          bodyType: Body.Static
          collisionTestingOnlyMode: true
          fixture.onBeginContact: {
              var fixture = other;
              var body = fixture.getBody()
              var collidedEntity = body.target;
              var collidedEntityType = collidedEntity.entityType;
              if(collidedEntityType === "player") {
                            audioManager.play(audioManager.idCoin)
          }
          sensor: true
    }
    }

    MovementAnimation {
       id: movement
       target: gold
       property: "x"
       minPropertyValue: 0
       velocity: -50-Math.random()*50+gameScence1.goldspeed
       running: gameScence1.gameState!=="gameOver" && gameScence1.gameState!=="wait"
       onLimitReached: {
         gold.x = 970
         gold.y = -10+Math.random()*590
       }


     }


}
