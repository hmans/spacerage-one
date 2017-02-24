HasVelocity = require "../components/has_velocity"
CanUpdate = require "../components/can_update"

class Bullet extends PIXI.Graphics
  constructor: (color = 0xFFFFFF) ->
    super()

    CanUpdate(@)
    HasVelocity(@)

    @drag = 1
    @created = Date.now()

    # Draw an actual bullet, hooray!
    @beginFill(color, 0.1)
    @drawCircle(0, 0, 12)
    @beginFill(color, 1)
    @drawCircle(0, 0, 6)



module.exports = Bullet
