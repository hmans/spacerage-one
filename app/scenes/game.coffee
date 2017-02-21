Camera = require "../camera"
Vec2 = require "../vec2"
Background = require "../entities/background"
Velocity = require "../components/velocity"

class StupidSkewTrick
  @bless: (obj) ->
    app.ticker.add ->
      obj.skew.set(obj.angularVelocity / 3)

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
    @ship = PIXI.Sprite.fromImage "/img/ship.png"
    @ship.scale.set 0.8
    @ship.anchor.set 0.5
    Velocity.bless(@ship)
    StupidSkewTrick.bless(@ship)


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
      @ship.accelerateForward(0.8 / delta)

    if (key.isPressed("S") || key.isPressed("down"))
      @ship.accelerateForward(-0.5 / delta)

    if (key.isPressed("A") || key.isPressed("left"))
      @ship.accelerateRotation(-0.005 / delta)

    if (key.isPressed("D") || key.isPressed("right"))
      @ship.accelerateRotation(0.005 / delta)
