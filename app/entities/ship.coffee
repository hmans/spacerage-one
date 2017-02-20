Vec2 = require "../vec2"

module.exports = class Ship extends PIXI.Sprite
  constructor: ->
    @texture = PIXI.Texture.fromImage "/img/ship.png"
    super(@texture)

    # set up velocity (could be a component?)
    @velocity = new Vec2
    @angularVelocity = 0
    app.ticker.add @updateVelocity

    # EXPERIMENTAL: skew image according to rotation
    app.ticker.add =>
      @skew.set(@angularVelocity / 2.5)

  updateVelocity: (delta) =>
    # Apply velocity to our position
    @x += @velocity.x / delta
    @y += @velocity.y / delta

    # Apply drag to velocity
    @velocity = @velocity.scale(0.95 / delta)

    # Apply angular velocity to our rotation
    @rotation += @angularVelocity / delta

    # Apply drag to angular velocity
    @angularVelocity *= 0.95 / delta

  accelerate: (vec) ->
    @velocity = @velocity.add(vec)

  accelerateRotation: (n) ->
    @angularVelocity += n
