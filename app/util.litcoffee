This is the `Util` service module. It provides a bunch of utility
methods that I couldn't find a nicer placer for anywhere else.

    Util = {}

`Util.clamp` will clamp a number between the two given values.

    Util.clamp = (n, min, max) ->
      Math.min(Math.max(n, min), max)


    module.exports = Util
