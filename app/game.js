import * as PIXI from "pixi.js"
import Ship from "./entities/ship"

class Game {
  run() {
    this.app = new PIXI.Application(800, 600)
    document.body.appendChild(this.app.view)

    let ship = new Ship()
    this.app.stage.addChild(ship)
  }
}

export default Game
