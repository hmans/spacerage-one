require "pixi.js"
require "keymaster"
require "howler"

window.TWEEN = require "tween.js"

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
      @start = Date.now()
      @lag = 0
      @frameDuration = 1000 / 60
      @startScene(new GameScene())
      app.ticker.add @update.bind(this)

  startScene: (scene) ->
    if @scene
      app.stage.removeChild(@scene)

    @scene = scene
    app.stage.addChild(@scene)

  update: (delta) ->
    now = Date.now()
    elapsed = now - @start
    @start = now

    @lag += elapsed

    while @lag >= @frameDuration
      TWEEN.update()
      @scene?.update(1)
      @lag = @lag - @frameDuration
