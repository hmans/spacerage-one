Camera = require "../camera"
Vec2 = require "../vec2"
Background = require "../entities/background"
Enemy = require "../entities/enemy"
HasVelocity = require "../components/has_velocity"
CanUpdate = require "../components/can_update"

HasStupidSkewTrick = (obj) ->
  app.ticker.add ->
    obj.skew.set(obj.angularVelocity / 4)

module.exports = class GameScene extends PIXI.Container
  constructor: ->
    super()

    # set up world
    @world = new PIXI.Container
    @addChild @world

    # set up camera
    @camera = new Camera(@world)

    # set up ship
    @ship = PIXI.Sprite.fromImage "/img/ship.png"
    @ship.scale.set 0.6
    @ship.anchor.set 0.5
    CanUpdate(@ship)
    HasVelocity(@ship)
    HasStupidSkewTrick(@ship)

    # set up bullets
    @bullets = new PIXI.Container

    # set up enemies
    @enemies = new PIXI.Container

    # set up background
    @background = new Background(@ship)

    # Add entities to our world stage
    @world.addChild @background
    @world.addChild @ship
    @world.addChild @bullets
    @world.addChild @enemies


  update: (delta) ->
    now = Date.now()

    @camera.lookAt(@ship)
    @ship.update(delta)

    @handleInput(delta)

    # update bullets
    for bullet, i in @bullets.children by -1
      bullet.update(delta)
      if now > bullet.created + 1000
        @bullets.removeChildAt(i)

    # update enemies
    for enemy, i in @enemies.children by -1
      enemy.update(delta)


  handleInput: (delta) ->
    if (key.isPressed("W") || key.isPressed("up"))
      @ship.accelerateForward(0.8 / delta)

    if (key.isPressed("S") || key.isPressed("down"))
      @ship.accelerateForward(-0.5 / delta)

    if (key.isPressed("A") || key.isPressed("left"))
      @ship.accelerateRotation(-0.005 / delta)

    if (key.isPressed("D") || key.isPressed("right"))
      @ship.accelerateRotation(0.005 / delta)

    if (key.isPressed("space"))
      @fireBullet() if @canFireBullet()

    if (key.isPressed("e"))
      @spawnEnemy()

  canFireBullet: ->
    Date.now() > (@lastFiredAt || 0) + 50

  fireBullet: ->
    @bullets.addChild @makeBullet(-43, -4)
    @bullets.addChild @makeBullet(43, -4)
    @lastFiredAt = Date.now()

  makeBullet: (offsetX = 0, offsetY = 0) ->
    bullet = new PIXI.Graphics
    bullet.beginFill(0xFFFFFF, 0.1);
    bullet.drawCircle(0, 0, 15);
    bullet.beginFill(0xFFFFFF, 0.4);
    bullet.drawCircle(0, 0, 8);
    bullet.beginFill(0xFFFFFF, 1);
    bullet.drawCircle(0, 0, 5);

    # set up initial position and movement
    CanUpdate(bullet)
    HasVelocity(bullet)
    bullet.position = new Vec2(@ship.x, @ship.y).add(new Vec2(offsetX, offsetY).rotate(@ship.rotation))
    bullet.rotation = @ship.rotation
    bullet.drag = 1
    bullet.accelerateForward(20)

    # set up ticker to remove bullet
    bullet.created = Date.now()

    bullet


  spawnEnemy: ->
    @enemies.addChild @makeEnemy()

  makeEnemy: ->
    enemy = new Enemy

    enemy.position = Vec2.up
      .scale(Math.random() * 1000)
      .rotate(Math.random() * 2 * Math.PI)
      .add(new Vec2(@ship.x, @ship.y))

    enemy.rotation = Math.random() * 2 * Math.PI

    enemy.accelerateForward(3)

    enemy
