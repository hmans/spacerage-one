Bar = require "../bar"

class HUD extends PIXI.Container
  constructor: (@scene) ->
    super()

    # health bar
    @addChild @healthBar = new Bar(430, 50, 0xcc3333)
    @healthBar.x = SpaceRage.width - 450
    @healthBar.y = 20

    # shield bar
    @addChild @shieldBar = new Bar(430, 20, 0x6666cc)
    @shieldBar.x = SpaceRage.width - 450
    @shieldBar.y = 70

  update: =>
    @healthBar.value = @scene.ship.healthFactor()
    @healthBar.update()
    @shieldBar.update()

module.exports = HUD
