//A monster that only shoots bullets forward


import Felgo 3.0
import QtQuick 2.0
import"../scene"
EntityBase {


    property int monsterVocity:movement.velocity

    property int stdTimeDistanceBetweenBullets: 1000 // standard time distance between two bullets
    property int minTimeDistanceBullet: stdTimeDistanceBetweenBullets // interval between two bullets
    id: monster

    width: 32
    height: 32
    entityType: "monster1"

    Image {
         id: monsterbase
         source: "../../assets/monster1.png"
         width: 32
         height: 32
         anchors.top: monster.bottom
         anchors.horizontalCenter: monster.horizontalCenter
       }

    BoxCollider {
          anchors.fill: monster
          bodyType: Body.Static
          collisionTestingOnlyMode: true
          fixture.onBeginContact: {
              var fixture = other;
              var body = fixture.getBody()
              var collidedEntity = body.target;
              var collidedEntityType = collidedEntity.entityType;
               if(collidedEntityType === "bullet") {
                   console.debug("shot a monster!")
                  gameScence1.score++
                  collidedEntity.removeEntity()
                  removeEntity()
              }
               if(collidedEntityType === "ground") {
                   console.debug("destory a monster!!!!!!!!!!!!!!!!!")
                   monster.destory()
               }

          sensor: true
    }
    }

    MovementAnimation {
       id: movement
       target: monster
       property: "x"
       minPropertyValue: 0
       velocity: -100-Math.random()*50+gameScence1.goldspeed
       running: gameScence1.gameState!=="gameOver" && gameScence1.gameState!=="wait"
       onLimitReached: {
         monster.x = 960
         monster.y = -10+Math.random()*590
       }

     }
    Component{
    id:monsterbullet
    MonsterBullet{
    entityType: "monsterbullet"
            }
    }
    Timer{
    running: gameScence1.gameState!=="wait"&&gameScence1.gameState!=="gameOver"
    repeat: true
    interval: 1000
    onTriggered: {
                 monstershotbullet()
    }
    }
    property real last1Time: 0
    function monstershotbullet(){
    console.debug("monster shot bullet")
    var currentTime = new Date().getTime()
    var timeDiff = currentTime - last1Time

    // if enough time has passed, create a new bullet
    if (timeDiff > monster.minTimeDistanceBullet) {
  last1Time = currentTime
    var startX=(16 * Math.cos((rotation) * Math.PI / 180)) + monster.x + monster.width / 2
    var startY=(16 * Math.sin((rotation) * Math.PI / 180)) + monster.y + monster.height / 2
    var start1=Qt.point(startX,startY)
    var velocity=movement.velocity-100
        entityManager.createEntityFromComponentWithProperties(monsterbullet,{
                                                      "start":start1,
                                                      "velocity":velocity}
                                                      )
            }

}
}
