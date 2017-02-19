Ship = require "../entities/ship"

class GameScene
  constructor: ->
    @ship = new Ship

  init: ->
    app.stage.addChild @ship.sprite


  update: (delta) ->


module.exports = GameScene
