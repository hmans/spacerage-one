Scene = require "../scene"
Util = require "../util"

class ProcSpaceship extends PIXI.Graphics
  constructor: (@color = 0xFFFFFF) ->
    super()

    @cacheAsBitmap = true

    # draw the ship hull
    width = Util.rand(20, 70)
    height = width + Util.rand(100)

    @beginFill @color
    @drawRect -width / 2, -height / 2, width, height

    # draw a cockpit
    [w, h] = @addCockpit width, -height / 2
    @addCockpit w, -(height+h) / 2

    # add wings
    [ww, wh] = @addWing width, height
    [ww, wh] = @addWing width + ww, wh

  addWing: (ow, oh) ->
    tw = ow * Util.rand(0.5, 0.95)
    th = oh * Util.rand(0.5, 0.95)

    @drawPolygon ow / 2, oh / 2,
      ow / 2, -oh / 2,
      (ow + tw) / 2, -th / 2,
      (ow + tw) / 2, th / 2

    @drawPolygon -ow / 2, oh / 2,
      -ow / 2, -oh / 2,
      -(ow + tw) / 2, -th / 2,
      -(ow + tw) / 2, th / 2

    [tw, th]


  addCockpit: (width, y) ->
    color = 0xff0000
    w = width * Util.rand(0.5, 0.9)
    h = Util.rand(5, 20)

    @drawPolygon width / 2, y,
      -width / 2, y,
      -w / 2, y - h,
      w / 2, y - h

    [w, h]

class TestScene extends Scene
  constructor: ->
    super()

    for i in [0..15]
      ship = new ProcSpaceship
      ship.x = i % 4 * 230
      ship.y = Math.floor(i / 4) * 230
      @addChild ship

    @calculateBounds()
    @pivot.set(-400, -100)

module.exports = TestScene
