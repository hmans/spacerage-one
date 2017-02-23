key = require 'keymaster'

class Joystick
  up: ->
    key.isPressed("W") || key.isPressed("up")

  down: ->
    key.isPressed("S") || key.isPressed("down")

  left: ->
    key.isPressed("A") || key.isPressed("left")

  right: ->
    key.isPressed("D") || key.isPressed("right")

  keyIsPressed: (k) ->
    key.isPressed(k)

  update: ->
    @y = if @up()
      1
    else if @down()
      -1
    else
      0

    @x = if @left()
      -1
    else if @right()
      1
    else
      0


module.exports = Joystick
