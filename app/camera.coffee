module.exports = class Camera
  constructor: (@container) ->

  lookAt: (target) ->
    if window.location.hash == '#nosickness'
      @container.x = app.renderer.width / 2
      @container.y = app.renderer.height / 2
      @container.pivot.set(target.x, target.y)
    else
      @container.x = app.renderer.width / 2
      @container.y = app.renderer.height / 2 + 280
      @container.pivot.set(target.x, target.y)

      # rotate towards target's rotation
      @container.rotation = - target.rotation
