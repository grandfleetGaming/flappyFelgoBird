import QtQuick 2.0
import Felgo 3.0

 EntityBase {
   id: player
   entityType: "player"
   width: 26
   height: 26

   SpriteSequence {
     id: bird
     // adjust the rotation of the bird depending on its vertical speed
     rotation: collider.linearVelocity.y/10
     anchors.centerIn: parent
     running: scene.gameState != "gameOver"
     Sprite {
       frameCount: 3
       frameRate: 10
       frameWidth: 88
       frameHeight: 73
       source: "../assets/plane.png"
     }
   }

   BoxCollider {
    id: collider
    y: -25
    width: 44
    height: 70
   }

   function push() {
      collider.body.linearVelocity = Qt.point(0,0)
      var localForwardVector = collider.body.toWorldVector(Qt.point(0,-180));
      collider.body.applyLinearImpulse(localForwardVector, collider.body.getWorldCenter());
    }
 }
