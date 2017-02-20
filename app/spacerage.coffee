require "pixi.js"

GameScene = require "./scenes/game"

module.exports = SpaceRage =
  start: ->
    # Set up PIXI app
    app = new PIXI.Application(800, 600)
    document.body.appendChild app.view
    window.app = app

    # load assets
    loader = PIXI.loader
    loader.add "ship", "/img/ship.png"
    loader.add "background", "/img/space.jpg"
    loader.load =>
      @startScene(new GameScene())
      app.ticker.add @update.bind(this)

  startScene: (scene) ->
    if @scene
      app.stage.removeChild(@scene)

    @scene = scene
    app.stage.addChild(@scene)

  update: (delta) ->
    @scene?.update(delta)
