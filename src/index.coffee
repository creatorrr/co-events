{EventEmitter} = require 'events'
co = require 'co'

class module.exports extends EventEmitter
  on: (type, listener) ->
    # Wrap listener in co
    fn = (args...) ->
      co(listener) args...

    # removeListener uses .listener property to identify wrapped listeners
    fn.listener = listener

    # Attach listener
    super type, fn

  once: (type, listener) ->
    fired = false

    # Wrap listener
    fn = (args...) ->
      # Remove listener and execute
      @removeListener type, fn

      unless fired
        fired = true
        co(listener) args...

    fn.listener = listener

    # Attach using super on
    EventEmitter::on.call this, type, fn

    # Return this for chaining
    this
