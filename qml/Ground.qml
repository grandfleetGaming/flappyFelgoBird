import QtQuick 2.0
import Felgo 3.0

EntityBase {
   id: ground
   entityType: "ground"
   width: sprite.width
   height: sprite.height
   SpriteSequence {
     id: sprite
     running: scene.gameState != "gameOver"
     Sprite {
       frameCount: 2
       frameRate: 4
       frameWidth: 368
       frameHeight: 90
       source: "../assets/land.png"
     }
   }
   BoxCollider {
      anchors.fill: parent
      bodyType: Body.Static
      fixture.onBeginContact: {
        scene.stopGame()
      }
   }
 }
