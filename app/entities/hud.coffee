class HUD extends PIXI.Container
  healthbarSize: { x: 430, y: 50 }

  constructor: (@scene) ->
    super()

    @healthbar = new PIXI.Graphics

    @addChild @healthbar


  update: =>
    threshold = @scene.ship.healthFactor() * @healthbarSize.x

    @healthbar.clear()
      .beginFill 0xFF0000, 0.8
      .drawRect SpaceRage.width - 450, 20, threshold, @healthbarSize.y
      .beginFill 0xFFFFFF, 0.2
      .drawRect SpaceRage.width - 450 + threshold, 20, @healthbarSize.x - threshold, @healthbarSize.y




module.exports = HUD
