//Monster that fire bullets at players


import Felgo 3.0
import QtQuick 2.0
import"../scene"
EntityBase {


    property int monsterVocity:movement.velocity//Monster's speed

    property int stdTimeDistanceBetweenBullets: 3000 // standard time distance between two bullets
    property int minTimeDistanceBullet: stdTimeDistanceBetweenBullets // interval between two bullets
    id: monster20

    width: 32
    height: 32
    entityType: "monster2"

    Image {
         id: monsterbase
         source: "../../assets/shilaike.png"
         width: 32
         height: 32
         anchors.top: monster2.bottom
         anchors.horizontalCenter: monster20.horizontalCenter
       }

    BoxCollider {
          anchors.fill: monster20
          bodyType: Body.Static
          collisionTestingOnlyMode: true
          fixture.onBeginContact: {
              var fixture = other;
              var body = fixture.getBody()
              var collidedEntity = body.target;
              var collidedEntityType = collidedEntity.entityType;
               if(collidedEntityType === "bullet") {
                  gameScence1.score++
                  collidedEntity.removeEntity()
                  removeEntity()
              }
               if(collidedEntityType === "ground") {
                   console.debug("remove a monster2!")
                   removeEntity()
               }

          sensor: true
    }
    }

    MovementAnimation {
       id: movement
       target: monster20
       property: "x"
       minPropertyValue: 0
       velocity: -50-Math.random()*50+gameScence1.goldspeed
       running: gameScence1.gameState!=="gameOver" && gameScence1.gameState!=="wait"
       onLimitReached: {
         monster20.x = 960
         monster20.y = -10+Math.random()*590
       }

     }
    Component{
    id:monsterbullet2
    MonsterBullet2{
    entityType: "monsterbullet2"

            }
    }
    Timer{
    running: gameScence1.gameState!=="wait"&&gameScence1.gameState!=="gameOver"
    repeat: true
    interval: 1000
    onTriggered: {
                 monstershotbullet2()

    }
    }
    property real last1Time: 0
    function monstershotbullet2(){//The monster fired a bullet
    console.debug("monster shot bullet")
    //Time interval between shots
    var currentTime = new Date().getTime()
    var timeDiff = currentTime - last1Time

    // if enough time has passed, create a new bullet
    if (timeDiff > monster20.minTimeDistanceBullet) {
  last1Time = currentTime


        entityManager.createEntityFromComponent(monsterbullet2)

    }
    }
}
