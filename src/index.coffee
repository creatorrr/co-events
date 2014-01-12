{EventEmitter} = require 'events'
co = require 'co'

class module.exports extends EventEmitter
  on: (type, listener) ->
    fn = (args...) ->
      co(listener) args...

    fn.listener = listener

    super type, fn
