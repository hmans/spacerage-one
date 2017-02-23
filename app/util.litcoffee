This is the `Util` service module. It provides a bunch of utility
methods that I couldn't find a nicer placer for anywhere else.

    Util = {}

## Math Helpers

### Util.clamp

Will clamp a number `n` between the two given values `min` and `max`.

    Util.clamp = (n, min, max) ->
      Math.min(Math.max(n, min), max)

### Util.rand

Provides some convenience functionality around the generation
of random numbers through `Math.random`.

`Util.rand()` will simply return a random value between 0 and 1 like `Math.random()` does.

`Util.rand(n)` will return a random value between 0 and `n`.

`Util.rand(n, m)` will return a random value between `n` and `m`.

    Util.rand = (n, m) ->
      if n? && m?
        n + Math.random() * (m - n)
      else if n?
        Math.random() * n
      else
        Math.random()

We also provide `Util.randInt` which is just like `Util.rand`, but will always
return an integer (as opposed to a float) value.

    Util.randInt = (n, m) ->
      Math.floor(Util.rand(n, m))


## That's all.

Let's export it!

    module.exports = Util
