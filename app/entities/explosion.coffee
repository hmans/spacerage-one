class Explosion extends PIXI.Graphics
  constructor: ->
    super()
    @radius = 30
    @opacity = 1
    @finished = false
    @started = Date.now()

  update: (delta) ->
    # update radius
    @radius += 3 / delta
    @opacity -= 0.005 / delta

    # draw
    @clear()
    @beginFill(0xFFFFFF, @opacity)
    @drawCircle(0, 0, @radius)


module.exports = Explosion
