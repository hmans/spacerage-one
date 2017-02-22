Camera = require "../camera"
Timer = require "../timer"
Vec2 = require "../vec2"
Background = require "../entities/background"
Enemy = require "../entities/enemy"
Explosion = require "../entities/explosion"
Explosions = require "../entities/explosions"
HasVelocity = require "../components/has_velocity"
CanUpdate = require "../components/can_update"

HasStupidSkewTrick = (obj) ->
  obj.updateMethods.push ->
    obj.skew.set(obj.angularVelocity / 4)

module.exports = class GameScene extends PIXI.Container
  constructor: ->
    super()

    # load sounds
    @fireSound = new Howl
      src: ['/sounds/laser.wav']
      volume: 0.3

    @explosionSound = new Howl
      src: ['/sounds/explosion.wav']
      volume: 0.4

    # set up timers
    @fireTimer = new Timer

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

    # set up debug text
    @debug = new PIXI.Text("moo", {fontFamily : 'Arial', fontSize: 24, fill : 0xff1010, align : 'center'})
    @debug.x = 10
    @debug.y = 10

    # Add entities to our world stage
    @world.addChild @background
    @world.addChild @ship
    @world.addChild @bullets
    @world.addChild @enemies
    @world.addChild @explosions
    # @addChild @debug

    # Start enemy spawner
    @scheduleSpawnEnemy()


  update: ->
    now = Date.now()

    @debug.text = "moo"

    @camera.lookAt(@ship)
    @ship.update()
    @background.update()

    @handleInput()

    # update enemies
    for enemy, i in @enemies.children by -1
      enemy.update()

    # update bullets
    for bullet, i in @bullets.children by -1
      # check bullet lifetime
      if now > bullet.created + 1000
        @bullets.removeChildAt(i)
      else
        bullet.update()

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
    @explosions.update()

  handleInput: ->
    if (key.isPressed("W") || key.isPressed("up"))
      @ship.accelerateForward(0.8)

    if (key.isPressed("S") || key.isPressed("down"))
      @ship.accelerateForward(-0.5)

    if (key.isPressed("A") || key.isPressed("left"))
      @ship.accelerateRotation(-0.005)

    if (key.isPressed("D") || key.isPressed("right"))
      @ship.accelerateRotation(0.005)

    if (key.isPressed("space"))
      @fireTimer.cooldown 100, =>
        @fireSound.play()
        @bullets.addChild @makeBullet(-43, -4)
        @bullets.addChild @makeBullet(43, -4)

    if (key.isPressed("e"))
      @spawnEnemy()

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
      if @enemies.children.length < 20
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
