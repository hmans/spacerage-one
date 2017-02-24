CanUpdate = require "../components/can_update"
HasVelocity = require "../components/has_velocity"
Vec2 = require "../vec2"
Timer = require "../timer"

class Enemy extends PIXI.Sprite
  constructor: (@target, @fireFn) ->
    super(PIXI.Texture.fromImage("/img/enemy.png"))
    @anchor.set(0.5)

    @fireTimer = new Timer

    CanUpdate(@)
    HasVelocity(@)

    @updateMethods.push @updateEnemy

  updateEnemy: =>
    # move towards target
    targetVec = new Vec2(@target.x, @target.y).subtract(@)
    lookVec = Vec2.up.rotate(@rotation)
    angle = targetVec.angleTo(lookVec)

    # stupid pseudo-3d rotation effect
    @scale.x = @scale.y - Math.abs(@angularVelocity * 5)

    if angle > 0.2
      @accelerateRotation +0.002
      @accelerateForward 0.3
    else if angle < -0.2
      @accelerateRotation -0.002
      @accelerateForward 0.3
    else
      @accelerateForward 0.3

      # fire at target
      if @fireFn? && targetVec.length() < 900
        @fireTimer.cooldown 250, =>
          @fireFn(@)


module.exports = Enemy
