import Scene from "../scene"
import Ship from "../entities/ship"

import "keymaster"

class GameScene extends Scene {
  constructor(game) {
    super(game)

    let ship = new Ship()
    this.stage.addChild(ship)
  }

  update(delta) {
  }
}

export default GameScene
