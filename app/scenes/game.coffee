class GameScene
  constructor: ->

  init: ->
    @ship = PIXI.Sprite.fromImage "/img/ship.png"
    app.stage.addChild @ship


  update: (delta) ->


module.exports = GameScene
