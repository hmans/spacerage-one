CanUpdate = require "../components/can_update"
HasVelocity = require "../components/has_velocity"
Vec2 = require "../vec2"

class Enemy extends PIXI.Sprite
  constructor: (@target) ->
    super(PIXI.Texture.fromImage("/img/enemy.png"))
    @anchor.set(0.5)
    @scale.set(0.7)

    CanUpdate(@)
    HasVelocity(@)

    @updateMethods.push =>
      targetVec = new Vec2(@target.x, @target.y).subtract(@)
      lookVec = Vec2.up.rotate(@rotation)
      angle = targetVec.angleTo(lookVec)

      if angle > 0.2
        @accelerateRotation +0.002
        @accelerateForward 0.3
      else if angle < -0.2
        @accelerateRotation -0.002
        @accelerateForward 0.3
      else
        @accelerateForward 0.3


module.exports = Enemy
