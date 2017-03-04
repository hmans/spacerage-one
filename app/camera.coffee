Vec2 = require "./vec2"

module.exports = class Camera extends PIXI.DisplayObject
  constructor: ->
    super()
    @offset = new Vec2(0, 240)

  lookAt: (target) ->
    @position = target.position
    @rotation = target.rotation

  update: ->
    @applyToParent()

  applyToParent: ->
    @parent.pivot.set(@x, @y)
    @parent.x = SpaceRage.width / 2 + @offset.x
    @parent.y = SpaceRage.height / 2 + @offset.y
    @parent.rotation = -@rotation
