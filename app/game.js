import * as PIXI from "pixi.js"
import Ship from "./entities/ship"
import GameScene from "./scenes/game_scene"

class Game {
  run() {
    this.app = new PIXI.Application(800, 600)
    document.body.appendChild(this.app.view)

    // let ship = new Ship()
    // this.app.stage.addChild(ship)

    let scene = new GameScene
    this.app.stage.addChild(scene.stage)
  }
}

export default Game
