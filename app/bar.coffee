class Bar extends PIXI.Sprite
  constructor: (width, height, color, alpha = 0.8, bgColor = 0xFFFFFF, bgAlpha = 0.2) ->
    super()
    @value = 1

    @gfx = new PIXI.Graphics
    @addChild @gfx

    # NOTE: the following is a little clumsy, but for some reason, directly
    # assigning these in the constructor signature wouldn't work. Eep!
    @_width = width
    @_height = height
    @color = color
    @alpha = alpha
    @bgColor = bgColor
    @bgAlpha = bgAlpha

  update: ->
    threshold = @value * @_width

    @gfx.clear()
      .beginFill @color, @alpha
      .drawRect 0, 0, threshold, @_height
      .beginFill @bgColor, @bgAlpha
      .drawRect threshold, 0, @_width - threshold, @_height



module.exports = Bar
