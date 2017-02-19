import Scene from "../scene"
import Ship from "../entities/ship"

class GameScene extends Scene {
  constructor(game) {
    super(game)

    let ship = new Ship()
    this.stage.addChild(ship)
  }
}

export default GameScene
