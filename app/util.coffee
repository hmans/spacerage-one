Util =
  clamp: (n, min, max) ->
    Math.min(Math.max(n, min), max)

module.exports = Util
