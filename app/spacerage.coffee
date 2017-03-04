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
    # Set up renderer
    @renderer = PIXI.autoDetectRenderer(500, 500)
    @stage = new PIXI.Container
    document.body.appendChild @renderer.view

    # Set up automatic resizing
    window.onresize = @resizeRenderer
    @resizeRenderer()

    # load assets
    loader = PIXI.loader
    loader.add "ship", "/img/ship.png"
    loader.add "background", "/img/space.jpg"
    loader.load =>
      @startScene(new GameScene())
      requestAnimationFrame @gameLoop.bind(@)

  resizeRenderer: =>
    width  = window.innerWidth
    height = window.innerHeight
    SpaceRage.renderer.resize width, height


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
