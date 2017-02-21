CanUpdate = require "../components/can_update"
HasVelocity = require "../components/has_velocity"

class Enemy extends PIXI.Sprite
  constructor: ->
    super(PIXI.Texture.fromImage("/img/enemy.png"))
    @anchor.set(0.5)
    @scale.set(0.7)

    CanUpdate(@)
    HasVelocity(@)

    @drag = 1

module.exports = Enemy
