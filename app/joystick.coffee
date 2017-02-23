class Joystick
  up: ->
    key.isPressed("W") || key.isPressed("up")

  down: ->
    key.isPressed("S") || key.isPressed("down")

  left: ->
    key.isPressed("A") || key.isPressed("left")

  right: ->
    key.isPressed("D") || key.isPressed("right")


module.exports = Joystick
