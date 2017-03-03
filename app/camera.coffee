module.exports = class Camera extends PIXI.DisplayObject
  constructor: ->
    super()

  lookAt: (target) ->
    @position = target.position

  update: ->
    @parent.pivot.set(@x, @y)
    @parent.x = SpaceRage.renderer.width / 2
    @parent.y = SpaceRage.renderer.height / 2
