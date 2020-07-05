//Bullet type of monster one


import QtQuick 2.0
import Felgo 3.0
import"../scene"
import"../entity"


EntityBase {
  id: monsterBullet1
  x: start.x
  y: start.y
  entityType: "monsterbullet1"

  // make the start and velocity vectors accessible from outside
  property point start
  property int velocity


  // the visual representation of the bullet depends on the bulletType
  Image {
    width: 7
    height: 14
    source: "../../assets/bullet1.png"
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

    // handle the collision
    fixture.onBeginContact: {
      var collidedEntity = other.getBody().target;
      var otherEntityId = collidedEntity.entityId;
      var otherEntityParent = collidedEntity.parent;
         var collidedEntityType = collidedEntity.entityType;
        if(collidedEntityType === "ground") {
            console.debug("remove a monsterbullet!")
            removeEntity()
        }
      }
    }


  // animate the bullet along its x-axis
  MovementAnimation {
    target: monsterBullet1
    property: "x"
    velocity: monsterBullet1.velocity
    running: true

  }
}

