//Border in normal mode


import QtQuick 2.0
 import Felgo 3.0
import"../scene"
 EntityBase {
   id: ground
   entityType: "ground"
   width: land.width
   height: land.height

   SpriteSequence {
     id: land

     Sprite {
       frameRate:4
       frameWidth: 960
       frameHeight: 110
       source: "../../assets/land1.png"
     }
   }
   BoxCollider {
      anchors.fill: ground
      bodyType: Body.Static
      fixture.onBeginContact: {
           gamescene2.resetGame()
      gameWindow.state="gameover"
      }
    }
 }
