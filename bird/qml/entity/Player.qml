//Characters controlled by players


import QtQuick 2.0
import Felgo 3.0

import".."

EntityBase {
  id: player
  width: 50
  height: 50
  entityType: "player"

  property int stdTimeDistanceBetweenBullets: 500 // standard time distance between two bullets
  property int minTimeDistanceBullet: stdTimeDistanceBetweenBullets // interval between two bullets

  SpriteSequence {
    id: spriteSequence
    anchors.centerIn: parent
    running: gameScence1.gameState!=="gameOver"
    Sprite {
      name: "idle"
      frameCount: 3
      frameRate: 10
      frameWidth: 34
      frameHeight: 24
      source: "../../assets/bird.png"
    }
    rotation: collider.linearVelocity.y/10
  }
  AudioManager{
  id:audioManager
  }
  CircleCollider {
       id: collider

       radius: spriteSequence.height/2
       anchors.centerIn: parent
       bodyType: Body.Dynamic
       fixture.onBeginContact: {
           var fixture = other;
           var body = fixture.getBody()
           var collidedEntity = body.target;
           var collidedEntityType = collidedEntity.entityType;
           if(collidedEntityType === "gold") {
             collidedEntity.removeEntity()
             gameScence1.score++;



           } else if(collidedEntityType === "ground" || collidedEntityType === "mines" || collidedEntityType === "monster1"||collidedEntityType === "monster2"||collidedEntityType === "monsterbullet"||collidedEntityType === "monsterbullet2") {

             gameScence1.gameState="gameOver";
           }
         }
     }

  function push() {
     collider.body.linearVelocity = Qt.point(0,0)
     var localForwardVector = collider.body.toWorldVector(Qt.point(0,-100));
     collider.body.applyLinearImpulse(localForwardVector, collider.body.getWorldCenter());

   }

}
