//Bullets fired by players


import QtQuick 2.0
import Felgo 3.0
import"../scene"

EntityBase {
  id:bullet
  width: 5
  height: 5
  x:start.x
  y:start.y
  entityType: "bullet"
  MultiResolutionImage {
    id: monsterImage
    source: "../../assets/Snowball"
    width: 25
    height: 25
    rotation: 180
  }

  // these values can then be set when a new projectile is created in the MouseArea below
  property point start
  property point destination
  property int moveDuration

  PropertyAnimation on x {
    from: player.x
    to: destination.x
    duration: moveDuration
    onStopped: {
        console.debug("destory a bullet")
    bullet.destroy()}
  }

  PropertyAnimation on y {
    from: player.y
    to: destination.y
    duration: moveDuration
    onStopped: {
        console.debug("destory a bullet")
    bullet.destroy()}
  }

  BoxCollider {
    anchors.fill: monsterImage
    collisionTestingOnlyMode: true
    fixture.onBeginContact: {
        var fixture = other;
        var body = fixture.getBody()
        var collidedEntity = body.target;
        var collidedEntityType = collidedEntity.entityType;
        if(collidedEntityType === "ground") {
            console.debug("remove a bullet!")
           removeEntity()
        }
    }
  }
}

