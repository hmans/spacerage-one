module.exports = class Camera
  constructor: (@container) ->

  lookAt: (target, delta) ->
    @container.x = app.renderer.width / 2
    @container.y = app.renderer.height / 2
    @container.pivot.set(target.x, target.y)
