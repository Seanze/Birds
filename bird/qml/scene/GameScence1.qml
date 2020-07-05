import QtQuick 2.0
import Felgo 3.0
import".."
import"../entity"

SceneBase {
    id: gameScence1
    sceneAlignmentY: "buttom"
    height: 600
    property int minesspeed: 0//the speed of the bomb
    property int goldspeed: 0//the speed of gold
    property int monsterspeed: 0//the speed of monster

    property int ve: 0
    property string playerState: "dBuffFalse"//Determination of state
     property alias player: player


    property string gameState: "wait"//Game state
    property int score: 0

    ParallaxScrollingBackground{
    id:backg
    anchors.fill: parent
    anchors.horizontalCenter: gameScence1.horizontalCenter
    anchors.bottom: gameScence1.gameWindowAnchorItem.bottom
    sourceImage: "../../assets/background.png"
    mirrorSecondImage: false
    movementVelocity: Qt.point(-200,0)

    }

    Text {
       text: score
       color: "white"
       anchors.horizontalCenter: gameScence1.horizontalCenter
       y: 30
       font.family: fontHUD
       font.pixelSize: 30
     }
    MenuButton{
        z:2
    text: qsTr("Back To Menu")
    anchors.right: gameScence1.gameWindowAnchorItem.right
    anchors.rightMargin: 10
    anchors.top: gameScence1.gameWindowAnchorItem.top
    anchors.topMargin:10
    onClicked: {
            backButtonPressed()
            audioManager.play(audioManager.idMenuclick)
        gameScence1.stopGame()
        }
    }
    MenuButton{
        z:2
    text: qsTr("Pause Game")
    anchors.left: gameScence1.gameWindowAnchorItem.left
    anchors.rightMargin: 10
    anchors.top: gameScence1.gameWindowAnchorItem.top
    anchors.topMargin:10
    onClicked: {
         gameWindow.state="pa1"
         audioManager.play(audioManager.idMenuclick)
        }
    }
//Add entity
   Component{
   id:mines
   Mines{
   id:mine
   entityType: "mines"
         }
   }
   Component{
   id:gold
   Gold{
   id:gol
   entityType: "gold"
            }
   }
   Component{
   id:bullet
   Bullet{
   id:bull
   entityType: "bullet"
        }
   }
   Component{
   id:badcorn1
   Badcorn{
   id:badc
   entityType: "badcorn1"
          }
   }
   Component{
   id:monster1
   Monster{
   id:monsterbase
   entityType: "monster1"
          }
   }
   Component{
   id:monster2
   Monster2{
   id:monter2base
   entityType: "monster2"}
   }

   Component{
   id:monsterbullet
   MonsterBullet{
   id:monsterbulletbase
   entityType: "monsterbullet"}
   }

    Ground{
        anchors.horizontalCenter: gameScence1.horizontalCenter
        anchors.bottom: gameScence1.gameWindowAnchorItem.bottom
    }

    Player {
      id: player
      x: 100
      y: 150
    }
    AudioManager{
    id:audioManager
    }

        property real lastTime: 0
    SoundEffect {//Sound effects of firing bullets
      id: shot
      source: "../../assets/SlowMo.wav" // gets played when a projectile is created below
    }
    SoundEffect {//Sound effects at the end of the game
      id: gameovermusic
      source: "../../assets/gameOver.wav" // gets played when a projectile is created below
    }
    MouseArea {
       anchors.fill: parent
       onReleased: {
//Players fire bullets
       if(gameScence1.gameState==="play"){//Interval between shots
           var currentTime = new Date().getTime()
           var timeDiff = currentTime - lastTime

           // if enough time has passed, create a new bullet
           if (timeDiff > player.minTimeDistanceBullet) {
             lastTime = currentTime

           var offset = Qt.point(
                 mouseX - player.x,
                 mouseY - player.y
                 );

           // Bail out if we are shooting down or backwards
           if(offset.x <= 0)
             return;

           var startX = (16 * Math.cos((rotation) * Math.PI / 180)) + player.x + player.width / 2
           var startY = (16 * Math.sin((rotation) * Math.PI / 180)) + player.y + player.height / 2
           var start =Qt.point(startX,startY)

           // Determine where we wish to shoot the bullet to
           var realX = gameScence1.gameWindowAnchorItem.width
           var ratio = offset.y / offset.x
           var realY = (realX * ratio) + player.y
           var destination = Qt.point(realX, realY)


           var length = 960
           var velocity = 400+ve
           var realMoveDuration = length / velocity * 1000 // multiply by 1000 because duration of bullet is in milliseconds
           entityManager.createEntityFromComponentWithProperties(bullet, {"start":start,
                                                                     "destination": destination,
                                                                     "moveDuration": realMoveDuration})
           shot.play()
                    }
       }
       }

       onPressed: {
         if(gameScence1.gameState == "wait") {
           gameScence1.startGame()

         } else if(gameScence1.gameState == "play") {
             gameScence1.leve()

         } else if(gameScence1.gameState == "gameOver") {
              gameovermusic.play()
                gameScence1.stopGame()
             gameWindow.state="gameover"

         }

       }
     }
    Keys.onSpacePressed: {
        player.push()
    }//the space key controls the player
//Entity added timer
    Timer{
    running: gameScence1.gameState!=="wait"&&gameScence1.gameState!=="gameOver"
    repeat: true
    interval:10000
    onTriggered: {
        addMonster()
        addMonster()
        addMines()
    }
    }
    Timer{
    running: gameScence1.gameState!=="wait"&&gameScence1.gameState!=="gameOver"
    repeat: true
    interval:20000
    onTriggered: {
        addBadCorn()
    }
    }
    Timer{
    running: gameScence1.gameState!=="wait"&&gameScence1.gameState!=="gameOver"
    repeat: true
    interval: 5000
    onTriggered: {
        addGold()
        deBuffDuration()
    }
    }
    Timer{
        id:badtime
    running: gameScence1.gameState!=="wait"&&gameScence1.gameState!=="gameOver"
    repeat: true
    interval: 30000
    onTriggered: {
        addMonster2()
        }
    }

    function startGame() {
        gameScence1.gameState = "play"
     }
    function stopGame() {
        entityManager.removeEntitiesByFilter(["mines","gold","badcorn1","monster1","monster2"])
        gameScence1.resetGame();
     }
    function resetGame() {
    gameScence1.gameState="wait"
        player.x=100+Math.random()*50
        player.y=100+Math.random()*100
        gameScence1.score=0
        minesspeed=0
        goldspeed=0
    }
    //Increasing difficulty
    function leve(){
        if(gameScence1.score==20) {
            minesspeed=minesspeed-5
            goldspeed=goldspeed-10
            monsterspeed=monsterspeed-10
        }else if(gameScence1.score==40){
            minesspeed=minesspeed-10
            goldspeed=goldspeed-15
            monsterspeed=monsterspeed-10
        }else if(gameScence1.score==60){
            minesspeed=minesspeed-15
            goldspeed=goldspeed-20
            monsterspeed=monsterspeed-10
        }else if(gameScence1.score==80){
            minesspeed=minesspeed-20
            goldspeed=goldspeed-25
            monsterspeed=monsterspeed-10
        }
    }
    function addMines(){
    console.debug("create a new mines")
        entityManager.createEntityFromComponent(mines)
    }
    function addGold(){
    console.debug("create a new gold")
        entityManager.createEntityFromComponent(gold)
    }
    function addBadCorn(){
    console.debug("create a new badcorn")
        entityManager.createEntityFromComponent(badcorn1)
    }
    function addMonster(){
    console.debug("create a new monster")

        entityManager.createEntityFromComponent(monster1)
    }
    function addMonster2(){
    console.debug("create a new monster")

        entityManager.createEntityFromComponent(monster2)
    }
    function deBuffDuration(){//Remove negative state
        console.debug("deBuff  Time   Over")
            ve=0
        gameScence1.playerState="dBuffFalse"

    }

}

