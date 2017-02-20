Vec2 = require "../vec2"

module.exports = class Velocity
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

    # set up velocity
    app.ticker.add obj.updateVelocity.bind(obj)
