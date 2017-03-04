Bar = require "../bar"

class HUD extends PIXI.Container
  constructor: (@scene) ->
    super()
    @healthBar = new Bar(430, 50, 0xFF0000)
    @addChild @healthBar
    @healthBar.x = SpaceRage.width - 450
    @healthBar.y = 20

  update: =>
    @healthBar.value = @scene.ship.healthFactor()
    @healthBar.update()

module.exports = HUD
