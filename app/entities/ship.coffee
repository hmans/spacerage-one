module.exports = class Ship extends PIXI.Sprite
  constructor: ->
    @texture = PIXI.Texture.fromImage "/img/ship.png"
    super(@texture)
