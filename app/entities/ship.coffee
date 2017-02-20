Vec2 = require "../vec2"

module.exports = class Ship extends PIXI.Sprite
  constructor: ->
    @texture = PIXI.Texture.fromImage "/img/ship.png"
    super(@texture)

    @velocity = new Vec2
    app.ticker.add @updateVelocity

  updateVelocity: (delta) =>
    # Apply velocity to our position
    @x += @velocity.x / delta
    @y += @velocity.y / delta

    # Apply friction to velocity
    @velocity = @velocity.scale(0.95 / delta)

  accelerate: (vec) ->
    @velocity = @velocity.add(vec)
