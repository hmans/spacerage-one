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
    @renderer = PIXI.autoDetectRenderer(800, 800)
    @stage = new PIXI.Container
    document.body.appendChild @renderer.view

    # Set up automatic resizing
    window.onresize = @resizeRenderer.bind(@)
    @resizeRenderer()

    # load assets
    loader = PIXI.loader
    loader.add "ship", "/img/ship.png"
    loader.add "background", "/img/space.jpg"
    loader.load =>
      @startScene(new GameScene())
      requestAnimationFrame @gameLoop.bind(@)

  resizeRenderer: ->
    # Resize the actual renderer
    width  = window.innerWidth
    height = window.innerHeight
    @renderer.resize width, height

    # Scale the stage to fit our new resolution
    scale = height / 800
    @stage.scale.set(scale)

    # Store actual gameplay area width and height for reference
    @width = width / scale
    @height = height / scale


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
