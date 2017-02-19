export default class Camera {
  constructor(container, width, height) {
    this.container = container
    this.width = width
    this.height = height
  }

  lookAt(pos) {
    this.container.position.set(this.width / 2, this.height / 2)
    this.container.pivot.set(pos.x, pos.y)
  }

  update(delta) {
  }
}
