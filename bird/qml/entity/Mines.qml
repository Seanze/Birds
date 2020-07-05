//An indelible bomb


import QtQuick 2.0
import Felgo 3.0
import"../scene"
EntityBase {
    id: mines
    entityType: "mines"
    property alias minesMovement: movement
     poolingEnabled: false
     preventFromRemovalFromEntityManager: false
    width: 24
    height: 24

    Image {
         id: mine
         source: "../../assets/mines.png"
         anchors.top: mines.bottom
         anchors.horizontalCenter: mines.horizontalCenter
       }

    BoxCollider {
          anchors.fill: mine
          bodyType: Body.Static
          collisionTestingOnlyMode: true
          fixture.onBeginContact: {           
              var fixture = other;
              var body = fixture.getBody()
              var collidedEntity = body.target;
              var collidedEntityType = collidedEntity.entityType;
              if(collidedEntityType === "bullet") {
                // the coin is pooled for better performance
                  collidedEntity.removeEntity()
              }
          }
    }
    BoxCollider {
           anchors.fill: mines
           bodyType: Body.Static
           collisionTestingOnlyMode: true
         }
    MovementAnimation {
       id: movement
       target: mines
       property: "x"
       minPropertyValue: 0
       velocity: -100-Math.random()*50+gameScence1.minesspeed
       running: gameScence1.gameState!=="gameOver" && gameScence1.gameState!=="wait"

       onLimitReached: {
         mines.x =960
         mines.y = -10+Math.random()*590
       }

     }

}
