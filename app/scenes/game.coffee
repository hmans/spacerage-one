Camera = require "../camera"
Timer = require "../timer"
Joystick = require "../joystick"
Util = require "../util"
Vec2 = require "../vec2"
Background = require "../entities/background"
Ship = require "../entities/ship"
HUD = require "../entities/hud"
Enemy = require "../entities/enemy"
Bullet = require "../entities/bullet"
Explosion = require "../entities/explosion"
Explosions = require "../entities/explosions"
HasVelocity = require "../components/has_velocity"
CanUpdate = require "../components/can_update"


module.exports = class GameScene extends PIXI.Container
  constructor: ->
    super()

    @state = "playing"

    # load sounds
    @fireSound = new Howl
      src: ['/sounds/laser.wav']
      volume: 0.3

    @explosionSound = new Howl
      src: ['/sounds/explosion.wav']
      volume: 0.4

    # start stupid music
    @music = new Howl
      src: ['/sounds/theme.mp3']
      autoplay: true
      loop: true
      volume: 1

    # set up timers
    @fireTimer = new Timer

    # set up world
    @world = new PIXI.Container
    @addChild @world

    # set up some tools
    @camera = new Camera(@world)
    @joystick = new Joystick(@)

    # set up entities
    @ship = new Ship
    @background = new Background(@ship)

    # set up containers
    @bullets = new PIXI.Container
    @enemyBullets = new PIXI.Container
    @enemies = new PIXI.Container
    @explosions = new Explosions

    # set up debug text
    @debug = new PIXI.Text("SPACERAGE! \\o/", {fontFamily : 'Arial', fontSize: 48, fill : 0xff1010, align : 'center'})
    @debug.x = 10
    @debug.y = 10

    # set up HUD
    @hud = new HUD(@)

    # Add entities to our world stage
    @world.addChild @background
    @world.addChild @ship
    @world.addChild @bullets
    @world.addChild @enemyBullets
    @world.addChild @enemies
    @world.addChild @explosions

    # Add some extra entities that live outside of the world
    @addChild @hud
    # @addChild @debug

    # Start enemy spawner
    @scheduleSpawnEnemy()

    # Set up some global key events
    key 'm', =>
      if @music.playing()
        @music.pause()
      else
        @music.play()


  update: ->
    now = Date.now()

    @joystick.update()
    @camera.lookAt(@ship)
    @ship.update()
    @background.update()
    @hud.update()

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

    # update enemy bullets
    for bullet, i in @enemyBullets.children by -1
      # check bullet lifetime
      if now > bullet.created + 3000
        @enemyBullets.removeChildAt(i)
      else
        bullet.update()

        distance = new Vec2(@ship.x, @ship.y).distance(bullet)
        if distance < 80
          # apply a bit of impact to the player ship
          @ship.velocity = @ship.velocity.add(bullet.velocity.scale(0.2))
          @ship.accelerateRotation(Util.rand(-0.01, 0.01))

          # remove bullet
          @enemyBullets.removeChildAt(i)

          if @ship.isAlive()
            # remove some health
            @ship.takeDamage(100)
            @playerDied() if @ship.isDead()

    # update explosions
    @explosions.update()

  handleInput: ->
    if @state == "playing"
      @ship.accelerateForward(0.8 * @joystick.y)
      @ship.accelerateRotation(0.005 * @joystick.x)

      if @joystick.fire()
        @fireTimer.cooldown 100, =>
          @fireSound.play()
          @bullets.addChild @makeBullet(-72, -10)
          @bullets.addChild @makeBullet(72, -10)

      if @joystick.keyIsPressed("e")
        @spawnEnemy()

    else if @state == "done"
      if @joystick.fire()
        # XXX: hook up some events
        SpaceRage.startScene(new GameScene())

  makeBullet: (offsetX = 0, offsetY = 0) ->
    bullet = new Bullet
    bullet.scale.set 1.3
    bullet.position = new Vec2(@ship.x, @ship.y).add(new Vec2(offsetX, offsetY).rotate(@ship.rotation))
    bullet.rotation = @ship.rotation
    bullet.accelerateForward(20)
    bullet


  spawnEnemy: ->
    @enemies.addChild @makeEnemy()

  scheduleSpawnEnemy: ->
    setTimeout =>
      if @enemies.children.length < 40
        @spawnEnemy()

      @scheduleSpawnEnemy()
    , 500

  makeEnemy: ->
    enemy = new Enemy(@ship, @fireEnemyBullet)

    enemy.position = Vec2.up
      .scale(Util.rand(1000, 2000))
      .rotate(Util.randAngle())
      .add(new Vec2(@ship.x, @ship.y))

    enemy.rotation = Util.randAngle()

    enemy

  fireEnemyBullet: (enemy) =>
    bullet = new Bullet(0xFF0000)
    bullet.position = new Vec2(enemy.x, enemy.y)
    bullet.rotation = enemy.rotation
    bullet.accelerateForward(10)

    @enemyBullets.addChild bullet

  playerDied: ->
    @state = "deathanim"
    @ship.visible = false

    @music.stop()

    # EXPLOSION!
    explosion = new Explosion()
    explosion.scale.set(5)
    explosion.position = @ship.position
    @explosions.addChild(explosion)
    @explosionSound.play()

    # DEATH TEXT!
    @message = new PIXI.Graphics

    text = new PIXI.Text "UR DEAD. SAD!",
      fontFamily: 'Arial Black'
      fontSize: 80
      fill: 0xFF0000

    @message
      .beginFill 0xFFFFFF
      .drawRect -100, -20, text.width + 200, text.height + 40
      .addChild text

    @message.pivot.set(text.width / 2, text.height / 2)
    @message.x = 800
    @message.y = 450
    @message.scale.set(20)
    @message.alpha = 0
    @message.rotation = Util.rand(-0.3, 0.3)

    duration = 1500

    new TWEEN.Tween(@message.scale)
      .to({ x: 1.5, y: 1.5}, duration)
      .easing(TWEEN.Easing.Quintic.In)
      .start()

    new TWEEN.Tween(@message)
      .to({alpha: 1, rotation: Util.rand(-0.3, 0.3)}, duration)
      .easing(TWEEN.Easing.Quintic.In)
      .start()

    setTimeout @waitForRestart, 2000

    @addChild @message

  waitForRestart: =>
    @state = "done"

    text = new PIXI.Text "PRESS RAGE TO RESTART",
      fontFamily: 'Arial Black'
      fontSize: 40
      fill: 0xFFFFFF

    text.alpha = 0
    text.pivot.set(text.width / 2, text.height / 2)
    text.x = 800
    text.y = 800

    @addChild text

    new TWEEN.Tween(text)
      .to({alpha: 1}, 1000)
      .easing(TWEEN.Easing.Quadratic.Out)
      .start()
