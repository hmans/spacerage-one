import { Container } from "pixi.js"

export default class Scene {
  constructor(game) {
    this.stage = new Container
    this.game = game
  }
}
