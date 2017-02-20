Camera = require "../camera"
Vec2 = require "../vec2"
Ship = require "../entities/ship"
Background = require "../entities/background"

require "keymaster"

module.exports = class GameScene extends PIXI.Container
  constructor: ->
    super()

    # set up world
    @world = new PIXI.Container
    @addChild @world

    # set up camera
    @camera = new Camera(@world)

    # set up ship
    @ship = new Ship
    @ship.anchor.set 0.5

    # set up background
    @background = new Background(@ship)

    # Add entities to our world stage
    @world.addChild @background
    @world.addChild @ship


  update: (delta) ->
    @handleInput(delta)
    @camera.lookAt(@ship)

  handleInput: (delta) ->
    if (key.isPressed("W") || key.isPressed("up"))
      @ship.accelerate(Vec2.up.scale(0.5 / delta).rotate(@ship.rotation))

    if (key.isPressed("S") || key.isPressed("down"))
      @ship.accelerate(Vec2.up.scale(-0.4 / delta).rotate(@ship.rotation))

    if (key.isPressed("A") || key.isPressed("left"))
      @ship.accelerateRotation(-0.005 / delta)

    if (key.isPressed("D") || key.isPressed("right"))
      @ship.accelerateRotation(0.005 / delta)
