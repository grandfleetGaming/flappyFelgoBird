import QtQuick 2.0
import Felgo 3.0

GameWindow {
   licenseKey: C4C82F5B62F99FEC55DA379604A7AD54328D8B6BEA8B16FD5D2014757DAA89328EFDDD79FFA91E980FABC6F4AF0564C4197E6BBD2F9B73BD09DFB52A47A2C557422D51C3D7B8430D7700D261AA50FB9C04AB5DC90E9BA503F2D1FE544F0360AFB52385EE4DDBA49FEEFCDCE8D547950625574ADDE9E96AC191A81FD274DDC393ABC3F3D902D58BDBD65836ACF6A65BAC486E7D0843431DDFEF01D4FC85B639858DEEA90225AEFEAD5F4A7961CE77F6D9DAA647C037C45811BB15AD30F9D5ACCAAE1EFA2A276F5CA70F48D7D78B8C0E7876CE62500C8BB7B97ED9D7BA87B0717479704BE41E879DA77D12A4C7E326279EE2D5B7FDC6C7E783F4C4C34185D2A4FAA271F0E25507EA3B1AD5D94F7EC9A46D9085BFDD96B9CDEB9C9C61DA1D9EBF11FBEA4507945CEDA8C04C419E1EBD7B01
   FelgoGameNetwork {
     // created in the Felgo Web Dashboard
     gameId: 5
     secret: "abcdefg1234567890"
   }

  id: gameWindow
  FelgoGameNetwork {
      id: gameNetwork
      gameId: 674
      secret: "abcdefghjkl0987654321"
      multiplayerItem: multiplayer
    }

  SocialView {
      id: socialView
      gameNetworkItem: gameNetwork
      multiplayerItem: multiplayer
  }
  // you get free licenseKeys as a V-Play customer or in your V-Play Trial
  // with a licenseKey, you get the best development experience:
  //  * No watermark shown
  //  * No license reminder every couple of minutes
  //  * No fading V-Play logo
  // you can generate one from https://v-play.net/developers/license/, then enter it below:
  //licenseKey: "<generate one from https://v-play.net/developers/license/>"

  activeScene: scene

  // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
  // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
  // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
  screenWidth: 320
  screenHeight: 480
  EntityManager {
    id: entityManager
  }

  Scene {
    id: scene
    property string gameState: "wait"
    property int score: 0
    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 320
    height: 480
    sceneAlignmentY: "bottom"
    PhysicsWorld {
      debugDrawVisible: true // set this to false to hide the physics debug overlay
      gravity.y: scene.gameState != "wait" ? 9.81 : 0 // 9.81 would be earth-like gravity, so this one will be pretty strong
      z: 1000 // set this high enough to draw on top of everything else
    }
    Image {
      id: bg
      source: "../assets/bg.png"
      anchors.horizontalCenter: scene.horizontalCenter
      anchors.bottom: scene.gameWindowAnchorItem.bottom
    }
    Pipe {
      id: pipe1
      x: 400
      y: 60+Math.random()*200
    }
    Pipe {
      id: pipe2
      x: 640
      y: 60+Math.random()*200
    }
    Ground {
      anchors.bottom: scene.bottom
      anchors.horizontalCenter: scene.horizontalCenter
    }
    Player {
      id: player
      x: 47
      y: 167
    }
    Text {
      text: scene.score
      color: "white"
      anchors.horizontalCenter: scene.horizontalCenter
      y: 30
      font.pixelSize: 30
    }
    Text {
      text: scene.gameState == "gameOver" ? "Game Over.\nPress to Restart" : ''
      color: "white"
      anchors.horizontalCenter: scene.horizontalCenter
      y: 80
      font.pixelSize: 30
    }
    MouseArea {
       anchors.fill: scene.gameWindowAnchorItem
       onPressed: {
           if(scene.gameState == "wait") {
              scene.startGame()
              player.push()
            } else if(scene.gameState == "play") {
              player.push()
            } else if(scene.gameState == "gameOver") {
              scene.reset()
            }
       }
    }
    function startGame() {
      scene.gameState = "play"
    }
    function stopGame() {
      scene.gameState = "gameOver"
    }
    function reset() {
      scene.gameState = "wait"
      pipe1.x = 400
      pipe1.y = 60+Math.random()*200
      pipe2.x = 640
      pipe2.y = 60+Math.random()*200
      player.x = 47
      player.y = 167
      scene.score = 0
    }
  }
}

