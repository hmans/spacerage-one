Camera = require "../camera"
Vec2 = require "../vec2"
Background = require "../entities/background"
Enemy = require "../entities/enemy"
Explosion = require "../entities/explosion"
Explosions = require "../entities/explosions"
HasVelocity = require "../components/has_velocity"
CanUpdate = require "../components/can_update"

HasStupidSkewTrick = (obj) ->
  app.ticker.add ->
    obj.skew.set(obj.angularVelocity / 4)

module.exports = class GameScene extends PIXI.Container
  constructor: ->
    super()

    # load sounds
    @fireSound = new Howl src: ['/sounds/laser.wav']
    @explosionSound = new Howl src: ['/sounds/explosion.wav']

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
    @enemies = new PIXI.particles.ParticleContainer

    # set up explosions
    @explosions = new Explosions

    # set up background
    @background = new Background(@ship)

    # Add entities to our world stage
    @world.addChild @background
    @world.addChild @ship
    @world.addChild @bullets
    @world.addChild @enemies
    @world.addChild @explosions

    # Start enemy spawner
    @scheduleSpawnEnemy()


  update: (delta) ->
    now = Date.now()

    @camera.lookAt(@ship)
    @ship.update(delta)

    @handleInput(delta)

    # update enemies
    for enemy, i in @enemies.children by -1
      enemy.update(delta)

    # update bullets
    for bullet, i in @bullets.children by -1
      # check bullet lifetime
      if now > bullet.created + 1000
        @bullets.removeChildAt(i)
      else
        bullet.update(delta)

        # check collisions
        for enemy, t in @enemies.children by -1
          distance = new Vec2(enemy.x, enemy.y).distance(new Vec2(bullet.x, bullet.y))

          if distance < 30
            # create an explosion for the enemy ship
            explosion = new Explosion()
            explosion.position = enemy.position
            @explosions.addChild(explosion)
            @explosionSound.play()

            # remove enemy and bullet
            @enemies.removeChildAt(t)
            @bullets.removeChildAt(i)

    # update explosions
    @explosions.update(delta)

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
    @fireSound.play()
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

  scheduleSpawnEnemy: ->
    setTimeout =>
      @spawnEnemy()
      @scheduleSpawnEnemy()
    , 500

  makeEnemy: ->
    enemy = new Enemy

    enemy.position = Vec2.up
      .scale(Math.random() * 1000)
      .rotate(Math.random() * 2 * Math.PI)
      .add(new Vec2(@ship.x, @ship.y))

    enemy.rotation = Math.random() * 2 * Math.PI

    enemy.accelerateForward(3)

    enemy
