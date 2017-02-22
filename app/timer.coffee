class Timer
  constructor: ->
    @touch()

  touch: ->
    @touched = Date.now()

  cooldown: (after, fn) ->
    if Date.now() > @touched + after
      @touch()
      fn()

module.exports = Timer
