Vec2 = require "../vec2"

class Velocity
  @bless: (obj) ->
    obj.velocity = new Vec2
    obj.angularVelocity = 0

    obj.accelerate = (vec) ->
      @velocity = @velocity.add(vec)

    obj.accelerateRotation = (n) ->
      @angularVelocity += n

    obj.updateVelocity = (delta) ->
      # Apply velocity to our position
      @x += @velocity.x / delta
      @y += @velocity.y / delta

      # Apply drag to velocity
      @velocity = @velocity.scale(0.95 / delta)

      # Apply angular velocity to our rotation
      @rotation += @angularVelocity / delta

      # Apply drag to angular velocity
      @angularVelocity *= 0.95 / delta

    # set up velocity (could be a component?)
    app.ticker.add obj.updateVelocity.bind(obj)


class StupidSkewTrick
  @bless: (obj) ->
    app.ticker.add ->
      obj.skew.set(obj.angularVelocity / 2.5)



module.exports = class Ship extends PIXI.Sprite
  constructor: ->
    @texture = PIXI.Texture.fromImage "/img/ship.png"
    super(@texture)
    @scale.set(0.8)

    Velocity.bless(@)
    StupidSkewTrick.bless(@)
