import * as PIXI from "pixi.js"
import Ship from "./entities/ship"
import GameScene from "./scenes/game_scene"

class Game {
  run() {
    this.app = new PIXI.Application(800, 600)
    document.body.appendChild(this.app.view)

    this.startScene(new GameScene(this))

    this.app.ticker.add((delta) => {
      this.update(delta)
    })
  }

  startScene(scene) {
    this.scene = scene
    this.app.stage.addChild(scene.stage)
  }

  update(delta) {
    this.scene.update(delta)
  }
}

export default Game
