require "pixi.js"

window.SpaceRage =
  start: ->
    app = new PIXI.Application(800, 600)
    document.body.appendChild app.view
    window.app = app
