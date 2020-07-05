//Pipe in normal mode


import QtQuick 2.0
import Felgo 3.0
import"../scene"
EntityBase {

   id: pipe

   entityType: "pipe"

   height: 100+gamescene2.tpipeh//Distance between two pipes
   width: 1

   Image {
     id: lowerPipe
     source: "../../assets/pipe.png"
     anchors.top: pipe.bottom
     anchors.horizontalCenter: pipe.horizontalCenter
   }

   Image {
     id: upperPipe
     source: "../../assets/pipe.png"
     mirror: true
     rotation: 180
     anchors.bottom: pipe.top
     anchors.horizontalCenter: pipe.horizontalCenter
   }
   MovementAnimation {
     id: movement
     target: pipe
     property: "x"
     minPropertyValue: 0
     velocity: -120+gamescene2.pipevelocity
     running: gamescene2.gameState !== "gameOver"&&gamescene2.gameState!=="wait"
     onLimitReached: {
       pipe.x = 960
       pipe.y = 200+Math.random()*200
     }

   }
   BoxCollider {
      anchors.fill: pipe
      bodyType: Body.Static
      collisionTestingOnlyMode: true
      fixture.onBeginContact: {
              gamescene2.score++
      }
    }

   BoxCollider {
        anchors.fill: lowerPipe
        bodyType: Body.Static
        collisionTestingOnlyMode: true
        fixture.onBeginContact: {
             gamescene2.resetGame()
          gameWindow.state="gameover"
        }
      }
      BoxCollider {
        anchors.fill: upperPipe
        bodyType: Body.Static
        collisionTestingOnlyMode: true
        fixture.onBeginContact: {
             gamescene2.resetGame()
         gameWindow.state="gameover"
        }
      }
 }
