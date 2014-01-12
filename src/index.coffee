{EventEmitter} = require 'events'
co = require 'co'

class module.exports extends EventEmitter
  on: (type, listener) ->
    fn = (args...) ->
      co(listener) args...

    fn.listener = listener

    super type, fn

  once: (type, listener) ->
    fired = false

    fn = (args...) ->
      @removeListener type, fn

      unless fired
        fired = true
        co(listener) args...

    fn.listener = listener

    EventEmitter::on.call this, type, fn
    this
