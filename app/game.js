import * as PIXI from "pixi.js"
import Ship from "./entities/ship"
import GameScene from "./scenes/game_scene"

class Game {
  run() {
    this.app = new PIXI.Application(800, 600)
    document.body.appendChild(this.app.view)

    this.startScene(new GameScene(this))
  }

  startScene(scene) {
    this.scene = scene
    this.app.stage.addChild(scene.stage)
  }
}

export default Game
