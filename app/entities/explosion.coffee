class Explosion extends PIXI.Graphics
  constructor: ->
    super()
    @beginFill(0xFFFFFF, 1)
    @drawCircle(0, 0, 80)

  update: (delta) ->
    

module.exports = Explosion
