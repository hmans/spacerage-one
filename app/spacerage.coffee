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
    @renderer = PIXI.autoDetectRenderer(1600, 900);
    @stage = new PIXI.Container
    document.body.appendChild @renderer.view

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

    # render the stage
    @renderer.render @stage



  startScene: (scene) ->
    if @scene
      @stage.removeChild(@scene)

    @scene = scene
    @stage.addChild(@scene)
