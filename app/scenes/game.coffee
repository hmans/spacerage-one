Ship = require "../entities/ship"

module.exports = class GameScene
  constructor: ->
    @ship = new Ship

  init: ->
    app.stage.addChild @ship.sprite


  update: (delta) ->
