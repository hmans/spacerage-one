key = require 'keymaster'
Vec2 = require './vec2'
Util = require './util'

class Joystick
  constructor: (@game) ->
    @stick = null
    document.addEventListener 'touchmove', @handleTouchEvent
    document.addEventListener 'touchend', =>
      @stick = null

  handleTouchEvent: (evt) =>
    evt.preventDefault()
    touches = evt.targetTouches

    if touches.length == 2
      # calculate stick direction
      [tl, tr] = touches
      vecl = new Vec2(tl.pageX, tl.pageY)
      vecr = new Vec2(tr.pageX, tr.pageY)
      [vecl, vecr] = [vecr, vecl] if vecl.x > vecr.x
      @stick = vecr.subtract(vecl).rotate(-Math.PI / 2).normalize()

      # set joystick y axis according to joystick position, not vector
      y = (1 - (vecr.y + vecl.y) / window.innerHeight) * 2 + 1
      @stick.y = Util.clamp(y, -1, 1)
    else
      @stick = null

  up: ->
    key.isPressed("W") || key.isPressed("up")

  down: ->
    key.isPressed("S") || key.isPressed("down")

  left: ->
    key.isPressed("A") || key.isPressed("left")

  right: ->
    key.isPressed("D") || key.isPressed("right")

  fire: ->
    @keyIsPressed("space") || @stick?

  keyIsPressed: (k) ->
    key.isPressed(k)

  update: ->
    @x = 0
    @y = 0

    # Apply control stick
    if @stick?
      @x = @stick.x
      @y = @stick.y

    # Check keyboard input
    if @up()
      @y += 1

    if @down()
      @y -= 1

    if @right()
      @x += 1

    if @left()
      @x -= 1



module.exports = Joystick
