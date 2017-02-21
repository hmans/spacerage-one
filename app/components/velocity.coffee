Vec2 = require "../vec2"

module.exports = class Velocity
  @bless: (obj) ->
    obj.velocity = new Vec2
    obj.angularVelocity = 0
    obj.drag = 0.95
    obj.angularDrag = 0.95

    obj.accelerate = (vec) ->
      @velocity = @velocity.add(vec)

    obj.accelerateForward = (n) ->
      @accelerate Vec2.up.scale(n).rotate(@rotation)

    obj.accelerateRotation = (n) ->
      @angularVelocity += n

    obj.updateVelocity = (delta) ->
      # Apply velocity to our position
      @x += @velocity.x / delta
      @y += @velocity.y / delta

      # Apply drag to velocity
      @velocity = @velocity.scale(@drag / delta)

      # Apply angular velocity to our rotation
      @rotation += @angularVelocity / delta

      # Apply drag to angular velocity
      @angularVelocity *= @angularDrag / delta

    # set up velocity
    app.ticker.add obj.updateVelocity.bind(obj)
