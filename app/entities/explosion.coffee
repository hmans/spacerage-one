class Explosion extends PIXI.Graphics
  constructor: ->
    super()

    @radius = 30
    @opacity = 1
    @finished = false

    new TWEEN.Tween(@)
      .to({radius: 100, opacity: 0.0}, 1000)
      .easing(TWEEN.Easing.Quadratic.Out)
      .onComplete ->
        @finished = true
      .start()

  update: ->
    @clear()
    @beginFill(0xFFFFFF, @opacity)
    @drawCircle(0, 0, @radius)


module.exports = Explosion
