HasVelocity = require "../components/has_velocity"
CanUpdate = require "../components/can_update"

HasStupidSkewTrick = (obj) ->
  obj.updateMethods.push ->
    obj.skew.set(obj.angularVelocity / 4)

class Ship extends PIXI.Sprite
  maxHealth: 1200
  maxShield: 1200
  shieldRechargeDelay: 2000
  shieldRechargeAmount: 5

  constructor: ->
    texture = PIXI.Texture.fromImage "/img/ship.png"
    super(texture)

    @anchor.set 0.5

    CanUpdate(@)
    HasVelocity(@)
    HasStupidSkewTrick(@)

    @drag = 0.97
    @angularDrag = 0.97


    @updateMethods.push @rechargeShield

    # game data
    @health = @maxHealth
    @shield = @maxShield
    @lastHitTime = Date.now()

  takeDamage: (amount) ->
    @lastHitTime = Date.now()
    @shield -= amount

    if @shield < 0
      @health += @shield
      @shield = 0

    @health = Math.max(0, @health)

  isAlive: ->
    @health > 0

  isDead: ->
    not @isAlive()

  rechargeShield: =>
    if Date.now() > @lastHitTime + @shieldRechargeDelay
      @shield = Math.min(@shield + @shieldRechargeAmount, @maxShield)

  healthFactor: ->
    @health / @maxHealth

  shieldFactor: ->
    @shield / @maxShield

module.exports = Ship
