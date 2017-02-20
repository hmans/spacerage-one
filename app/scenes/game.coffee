Ship = require "../entities/ship"

module.exports = class GameScene extends PIXI.Container
  constructor: ->
    super()
    @ship = new Ship
    @addChild @ship

  update: (delta) ->
