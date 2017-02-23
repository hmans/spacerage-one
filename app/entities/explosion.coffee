Vec2 = require "../vec2"
Util = require "../util"

class Explosion extends PIXI.Container
  constructor: ->
    super()
    @scale.set(Util.rand(0.3, 0.8))

    @finished = false

    @addChild @makeSplosion(Vec2.origin, 70, 1, 0xFFFF00)

    newSplosion = =>
      pos = Vec2.up.rotate(Util.rand(Math.PI * 2)).scale(Util.rand(20, 50))
      @addChild @makeSplosion(pos, Util.rand(5, 45), Util.rand(0.5, 1))

    num = Util.randInt(2, 12)

    for i in [1..num]
      setTimeout newSplosion, Util.rand(300)

    new TWEEN.Tween(@)
      .delay(500)
      .to({alpha: 0.0}, 1000)
      .easing(TWEEN.Easing.Quadratic.Out)
      .onComplete =>
        @finished = true
      .start()

  makeSplosion: (pos, radius = 50, alpha = 1, color = 0xFFFFFF) ->
    s = new PIXI.Graphics
    s.beginFill(color, alpha - 0.2)
    s.drawCircle(pos.x, pos.y, radius)
    s.beginFill(color, alpha)
    s.drawCircle(pos.x * Util.rand(0.8, 1.2), pos.y * Util.rand(0.8, 1.2), radius * 0.8)
    s._scale = 1

    targetPos = pos.scale(1.6)

    new TWEEN.Tween(s)
      .to({_scale: 2, x: targetPos.x, y: targetPos.y}, 1000)
      .easing(TWEEN.Easing.Quadratic.Out)
      .start()

    s.update = ->
      s.scale.set(s._scale)

    s

  update: ->
    for splosion in @children
      splosion.update()

module.exports = Explosion
