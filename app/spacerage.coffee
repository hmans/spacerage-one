require "pixi.js"

GameScene = require "./scenes/game"

module.exports = SpaceRage =
  start: ->
    # Set up PIXI app
    app = new PIXI.Application(800, 600)
    document.body.appendChild app.view
    window.app = app

    s = new GameScene()
    s.init()
