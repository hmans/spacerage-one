module.exports = class Vec2
  constructor: (@x = 0, @y = 0) ->

  add: (vec) ->
    new Vec2(@x + vec.x, @y + vec.y)

  subtract: (vec) ->
    new Vec2(@x - vec.x, @y - vec.y)

  length: ->
    Math.sqrt(@x * @x + @y * @y)

  scale: (n) ->
    new Vec2(@x * n, @y * n)

  rotate: (angle, center = {x: 0, y: 0}) ->
    r = []
    x = @x - center.x
    y = @y - center.y
    r[0] = x * Math.cos(angle) - y * Math.sin(angle)
    r[1] = x * Math.sin(angle) + y * Math.cos(angle)
    r[0] += center.x
    r[1] += center.y
    new Vec2(r[0], r[1])

  distance: (vec) ->
    x = @x - vec.x
    y = @y - vec.y
    Math.sqrt(x * x + y * y)

  dot: (vec) ->
    @x * vec.x + @y * vec.y


  @up: new Vec2(0, -1)

#
# Vec2.prototype.cross = function (vec) {
#   return (this.x * vec.y - this.y * vec.x);
# };
#
#
# Vec2.prototype.normalize = function () {
#   var len = this.length();
#   if (len > 0) {
#     len = 1 / len;
#   }
#   return new Vec2(this.x * len, this.y * len);
# };
#
#
# Vec2.UP = new Vec2(0, -1)
