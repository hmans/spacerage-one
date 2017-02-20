Velocity = require "../components/velocity"

class StupidSkewTrick
  @bless: (obj) ->
    app.ticker.add ->
      obj.skew.set(obj.angularVelocity / 3)


module.exports = class Ship extends PIXI.Sprite
  constructor: ->
    super(PIXI.Texture.fromImage "/img/ship.png")
    @scale.set(0.8)

    Velocity.bless(@)
    StupidSkewTrick.bless(@)
