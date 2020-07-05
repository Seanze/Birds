//Slow down the play's bullets


import QtQuick 2.0
import Felgo 3.0
import".."
EntityBase {
    id: badcorn


    entityType: "badcorn"

    Image {
         id: coin
         source: "../../assets/badCorn.png"
         width: 26
         height: 26
     //    anchors.top: badcorn.bottom
       ///  anchors.horizontalCenter: badcorn.horizontalCenter
       }
    AudioManager{
    id:audioManager
    }
    BoxCollider {
          anchors.fill: badcorn
          bodyType: Body.Static
          collisionTestingOnlyMode: true
          fixture.onBeginContact: {
              var fixture = other;
              var body = fixture.getBody()
              var collidedEntity = body.target;
              var collidedEntityType = collidedEntity.entityType;
              if(collidedEntityType === "player") {
                audioManager.play(audioManager.idBadcorn)
                console.debug("eat a badcorn")
                removeEntity()
                gameScence1.ve=gameScence1.ve-300//Slow down the bullet
                gameScence1.playerState="dBuffTrue"
          }
              if(collidedEntityType === "ground") {
                  console.debug("remove a badcorn!")
                  removeEntity()
              }
          sensor: true
    }
    }

    MovementAnimation {
       id: movement
       target: badcorn
       property: "x"
       minPropertyValue: 0
       velocity: -50-Math.random()*50+gameScence1.goldspeed
       running: gameScence1.gameState!=="gameOver" && gameScence1.gameState!=="wait"
       onLimitReached: {
         badcorn.x = 970
         badcorn.y = -10+Math.random()*590
       }
     }

}
