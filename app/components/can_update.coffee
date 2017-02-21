CanUpdate = (obj) ->
  obj.updateMethods = []

  obj.update = (delta) ->
    for meth in obj.updateMethods
      meth(delta)


module.exports = CanUpdate
