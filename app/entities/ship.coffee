HasVelocity = require "../components/has_velocity"
CanUpdate = require "../components/can_update"

HasStupidSkewTrick = (obj) ->
  obj.updateMethods.push ->
    obj.skew.set(obj.angularVelocity / 4)

class Ship extends PIXI.Sprite
  maxHealth: 2000
  maxShield: 2000

  constructor: ->
    texture = PIXI.Texture.fromImage "/img/ship.png"
    super(texture)

    @anchor.set 0.5

    CanUpdate(@)
    HasVelocity(@)
    HasStupidSkewTrick(@)

    # game data
    @health = @maxHealth
    @shield = @maxShield

  takeDamage: (amount) ->
    @shield -= amount

    if @shield < 0
      @health += @shield
      @shield = 0

    @health = Math.max(0, @health)

  isAlive: ->
    @health > 0

  isDead: ->
    not @isAlive()

  healthFactor: ->
    @health / @maxHealth

  shieldFactor: ->
    @shield / @maxShield

module.exports = Ship
