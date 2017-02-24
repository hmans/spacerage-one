HasVelocity = require "../components/has_velocity"
CanUpdate = require "../components/can_update"

HasStupidSkewTrick = (obj) ->
  obj.updateMethods.push ->
    obj.skew.set(obj.angularVelocity / 4)

class Ship extends PIXI.Sprite
  constructor: ->
    texture = PIXI.Texture.fromImage "/img/ship.png"
    super(texture)

    @anchor.set 0.5

    CanUpdate(@)
    HasVelocity(@)
    HasStupidSkewTrick(@)


module.exports = Ship
