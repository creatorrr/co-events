CoEvents = require '..'
assert = require 'assert'

# Utils
wait = (time) ->
  # Return thunk for co
  (cb) ->
    setTimeout (-> cb null, time), time

module.exports =
  'Co-events':
    'API':
      'Listeners can be anything that co supports viz. promises, thunks, generators, arrays or objects.': (callback) ->
        events = new CoEvents
        fs = require 'fs'
        read = (filename) ->
          (cb) ->
            fs.readFile filename, cb

        events.on 'readFile', (filename) ->*
          callback null, yield read filename

        events.emit 'readFile', 'LICENSE'

      'Good old EventEmitter style functions': (callback) ->
        events = new CoEvents
        fs = require 'fs'

        events.on 'readFile', (filename) ->
          callback null, fs.readFileSync filename

        events.emit 'readFile', 'LICENSE'

      'Listener called when event emitted': (callback) ->
        events = new CoEvents

        events.on 'event', ->*
          callback null

        events.emit 'event'

      'Arguments sent by emit are applied to listener': (callback) ->
        events = new CoEvents

        events.on 'wait', (time) ->*
          yield wait time
          callback null

        events.emit 'wait', 500

      'RemoveListener can remove attached listeners': (callback) ->
        events = new CoEvents

        fn = ->* 'Hello'
        events.on 'hello', fn

        events.removeListener 'hello', fn

        assert.equal false, events.emit 'hello'
        callback null

      'Events registered using .once are removed once they are fired': (callback) ->
        events = new CoEvents

        events.once 'hello', ->* 'Hello'
        events.emit 'hello'

        assert.equal false, events.emit 'hello'
        callback null

    'Aliases':
      '.off is an alias of .removeListener and .trigger is an alias of .emit': (callback) ->
        events = new CoEvents

        fn = ->* 'Hello'
        events.on 'hello', fn
        events.trigger 'hello'

        events.off 'hello', fn
        assert.equal false, events.trigger 'hello'
        callback null

