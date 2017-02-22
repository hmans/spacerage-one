class Explosion extends PIXI.Graphics
  constructor: ->
    super()

    # draw our silly little explosion
    @beginFill(0xFFFFFF, 1)
    @drawCircle(0, 0, 50)

    # set up an animation tween
    @finished = false
    @_scale = 1.0
    new TWEEN.Tween(@)
      .to({_scale: 2.5, alpha: 0.0}, 1000)
      .easing(TWEEN.Easing.Quadratic.Out)
      .onComplete ->
        @finished = true
      .start()

  update: ->
    @scale.set(@_scale)

module.exports = Explosion
