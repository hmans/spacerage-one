class Explosions extends PIXI.Container
  update: (delta) ->
    now = Date.now()

    for explosion, i in @children by -1
      if explosion.finished
        @removeChildAt(i)
      else
        explosion.update(delta)

module.exports = Explosions
