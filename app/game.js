import * as PIXI from "pixi.js"

class Game {
  run() {
    let app = new PIXI.Application(800, 600)
    document.body.appendChild(app.view)

    let hmans = PIXI.Sprite.fromImage('/img/hmans.jpg')
    app.stage.addChild(hmans)
  }
}

export default Game
