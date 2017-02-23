This is the `Util` service module. It provides a bunch of utility
methods that I couldn't find a nicer placer for anywhere else.

    Util = {}

### Math Helpers

#### Util.clamp

Will clamp a number `n` between the two given values `min` and `max`.

    Util.clamp = (n, min, max) ->
      Math.min(Math.max(n, min), max)

#### Util.rand

Provides some convenience functionality around the generation
of random numbers through `Math.random`.

    Util.rand = (n, m) ->
      if n? && m?
        n + Math.random() * (m - n)
      else if n?
        Math.random() * n
      else
        Math.random()


### That's all.

Let's export it!

    module.exports = Util