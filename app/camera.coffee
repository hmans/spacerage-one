module.exports = class Camera
  constructor: (@container) ->

  lookAt: (target) ->
    @container.x = app.renderer.width / 2
    @container.y = app.renderer.height / 2 + 180
    @container.pivot.set(target.x, target.y)

    # rotate towards target's rotation
    @container.rotation = - target.rotation
