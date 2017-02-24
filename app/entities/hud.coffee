class HUD extends PIXI.Container
  healthbarSize: { x: 700, y: 50 }

  constructor: (@scene) ->
    super()

    @healthbar = new PIXI.Graphics

    @addChild @healthbar


  update: =>
    threshold = @scene.ship.healthFactor() * @healthbarSize.x

    @healthbar.clear()
      .beginFill 0xFF0000, 0.8
      .drawRect 880, 20, threshold, @healthbarSize.y
      .beginFill 0xFFFFFF, 0.2
      .drawRect 880 + threshold, 20, @healthbarSize.x - threshold, @healthbarSize.y




module.exports = HUD
