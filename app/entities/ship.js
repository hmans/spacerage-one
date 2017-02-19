import { Sprite, Texture } from "pixi.js"

export default class Ship extends Sprite {
  constructor() {
    const texture = Texture.fromImage("/img/ship.png")
    super(texture)

    this.anchor.set(0.5)
  }
}
