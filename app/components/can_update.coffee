CanUpdate = (obj) ->
  obj.updateMethods = []

  obj.update = ->
    for meth in obj.updateMethods
      meth()


module.exports = CanUpdate
