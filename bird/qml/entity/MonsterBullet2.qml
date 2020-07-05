//Bullte type of monster two


import QtQuick 2.0
import Felgo 3.0
import"../scene"

EntityBase {
  id: monsterBullet2
  entityType: "monsterbullet2"

  MultiResolutionImage  {
    width: 7
    height: 14
    source: "../../assets/bullet1"
    anchors.centerIn: parent
  }

  BoxCollider {
    id: boxCollider
    width: 10
    height: 10
    anchors.fill: parent
    collisionTestingOnlyMode: true
    density: 0
    friction: 0
    restitution: 0
    body.bullet: true
    body.fixedRotation: false // if set to true the physics engine will NOT apply rotation to it

    fixture.onBeginContact: {
      var collidedEntity = other.getBody().target;
      var otherEntityId = collidedEntity.entityId;
      var otherEntityParent = collidedEntity.parent;
         var collidedEntityType = collidedEntity.entityType;
        if(collidedEntityType === "ground") {
            console.debug("remove a monsterbullet2!")
            removeEntity()
        }
      }
    }
  PropertyAnimation on x {
   from:monster20.x
   to:gameScence1.player.x-100
   duration: 2000   
  }
  PropertyAnimation on y{
  from: monster20.y
  to:gameScence1.player.y
  duration: 2000
  }
}

