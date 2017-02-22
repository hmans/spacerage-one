module.exports = class Background extends PIXI.particles.ParticleContainer
  constructor: (@target) ->
    super()
    @texture = PIXI.Texture.fromImage("/img/space.jpg")

    # Create grid of space tiles
    for i in [0..9]
      tile = new PIXI.Sprite(@texture)
      tile.x = i % 3 * @texture.width
      tile.y = Math.floor(i / 3) * @texture.height
      @addChild(tile)

    # Set pivot
    @pivot.set(1.5 * @texture.width, 1.5 * @texture.height)

  update: ->
    @x = Math.floor(@target.x / @texture.width) * @texture.width
    @y = Math.floor(@target.y / @texture.height) * @texture.height
