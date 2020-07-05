//Endless mode border

import QtQuick 2.0
import Felgo 3.0
import"../scene"
EntityBase {
    id: ground
    entityType: "ground"
    width: gameScence1.width
    height: gameScence1.height
    Image {
         id: lower
         source: "../../assets/land.png"
         anchors.bottom: ground.bottom
         anchors.horizontalCenter: ground.horizontalCenter
         visible: false
       }//bottom
    Image {
         id: upper
         source: "../../assets/land.png"
         mirror: true
         rotation: 180
         anchors.bottom: ground.top
         anchors.horizontalCenter: ground.horizontalCenter
         visible: false
       }//top
    Image {
        id: left
        source: "../../assets/Wall2.png"
        width: 15
        anchors.left: ground.left
        anchors.top: ground.top
        anchors.bottom: ground.bottom
        rotation: 180
        visible: false
    }//left
    BoxCollider{
    anchors.fill: left
    bodyType: Body.Static

    }
    BoxCollider {
        anchors.fill: upper
        bodyType: Body.Static
        fixture.onBeginContact: {
            var fixture = other;
            var body = fixture.getBody()
            var collidedEntity = body.target;
            var collidedEntityType = collidedEntity.entityType;
            if(collidedEntityType === "bullet") {
                console.debug("remove a bullet!")
                collidedEntity.removeEntity()
            }           
           }
    }
    BoxCollider {
        anchors.fill: lower
        bodyType: Body.Static
        fixture.onBeginContact: {
            var fixture = other;
            var body = fixture.getBody()
            var collidedEntity = body.target;
            var collidedEntityType = collidedEntity.entityType;
            if(collidedEntityType === "bullet") {
                collidedEntity.removeEntity()

            }
           }
    }
}
