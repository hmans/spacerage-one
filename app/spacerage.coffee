require "pixi.js"
require "keymaster"
require "howler"

window.TWEEN = require "tween.js"

GameScene = require "./scenes/game"

frameDuration = 1000 / 60
start = Date.now()
lag = 0

module.exports = SpaceRage =
  start: ->
    # Set up PIXI app
    app = new PIXI.Application(1600, 900)
    document.body.appendChild app.view
    window.app = app

    # load assets
    loader = PIXI.loader
    loader.add "ship", "/img/ship.png"
    loader.add "background", "/img/space.jpg"
    loader.load =>
      @startScene(new GameScene())
      requestAnimationFrame @gameLoop.bind(@)

  gameLoop: ->
    requestAnimationFrame @gameLoop.bind(@)

    now = Date.now()
    elapsed = now - start
    start = now

    lag += elapsed

    while lag >= frameDuration
      TWEEN.update()
      @scene?.update()
      lag = lag - frameDuration


  startScene: (scene) ->
    if @scene
      app.stage.removeChild(@scene)

    @scene = scene
    app.stage.addChild(@scene)
