CanUpdate = require "../components/can_update"
HasVelocity = require "../components/has_velocity"

class Enemy extends PIXI.Sprite
  constructor: ->
    super(PIXI.Texture.fromImage("/img/enemy.png"))
    @anchor.set(0.5)
    @scale.set(0.7)

    CanUpdate(@)
    HasVelocity(@)

    @updateMethods.push =>
      @rotation += 0.02
      @accelerateForward 0.3

module.exports = Enemy
