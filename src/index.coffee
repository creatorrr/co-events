{EventEmitter} = require 'events'
co = require 'co'

# Utils
_ =
  isFunction: (obj) -> 'function' is typeof obj
  isGeneratorFunction: (obj) -> obj and obj.constructor?.name is 'GeneratorFunction'

class module.exports extends EventEmitter
  on: (type, listener) ->
    if _.isFunction(listener) and not _.isGeneratorFunction listener
      super type, listener

    else
      # Wrap listener in co
      fn = (args...) ->
        co(listener).apply this, args

      # removeListener uses .listener property to identify wrapped listeners
      fn.listener = listener

      # Attach listener
      super type, fn

    # Return this for chaining
    this

  once: (type, listener) ->
    if _.isFunction(listener) and not _.isGeneratorFunction listener
      super type, listener

    else
      fired = false

      # Wrap listener
      fn = (args...) ->
        # Remove listener and execute
        @removeListener type, fn

        unless fired
          fired = true
          co(listener).apply this, args

      fn.listener = listener

      # Attach using super on
      EventEmitter::on.call this, type, fn

    # Return this for chaining
    this

  # Aliases
  off: (args...) -> @removeListener.apply this, args
  trigger: (args...) -> @emit.apply this, args
