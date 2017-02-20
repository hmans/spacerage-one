Camera = require "../camera"
Vec2 = require "../vec2"
Ship = require "../entities/ship"

require "keymaster"

module.exports = class GameScene extends PIXI.Container
  constructor: ->
    super()

    @world = new PIXI.Container
    @addChild @world

    @camera = new Camera(@world)

    @ship = new Ship
    @ship.anchor.set 0.5
    @world.addChild @ship

  update: (delta) ->
    @handleInput(delta)
    @camera.lookAt({x: 0, y:0})

  handleInput: (delta) ->
    if (key.isPressed("W") || key.isPressed("up"))
      @ship.accelerate(Vec2.up.scale(0.5 / delta).rotate(@ship.rotation))

    if (key.isPressed("S") || key.isPressed("down"))
      @ship.accelerate(Vec2.up.scale(-0.4 / delta).rotate(@ship.rotation))

    if (key.isPressed("A") || key.isPressed("left"))
      @ship.rotation -= 0.05 / delta

    if (key.isPressed("D") || key.isPressed("right"))
      @ship.rotation += 0.05 / delta
