class Explosions extends PIXI.Container
  update: (delta) ->
    now = Date.now()

    for explosion, i in @children by -1
      if now > explosion.started + 500
        @removeChildAt(i)
      else
        explosion.update(delta)

module.exports = Explosions
