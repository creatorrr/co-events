Events = require '..'
assert = require 'assert'

# Utils
_ =
  wait: (time) ->
    # Return thunk for co

    (cb) ->
      setTimeout (-> cb null, time), time

module.exports =
  'Co-events':
    'event listener':
      'should be added when .on is called': (done) ->
        events = new Events
        fs = require 'fs'

        try
          events.on 'readFile', (filename) ->*
            console.log yield fs.readFile filename

          done null

        catch e
          done e

      'should be called when event is triggered': (done) ->
        events = new Events

        events.on 'wait', ->*
          done null

        events.emit 'wait'

      'should be called with arguments passed by event': (done) ->
        events = new Events

        events.on 'wait', (time) ->*
          wait = yield _.wait time
          done null, wait

        events.emit 'wait', 500

      'should be removed when .removeListener is called': (done) ->
        events = new Events

        fn = ->* 'Hello'
        events.on 'hello', fn
        events.emit 'hello'

        events.removeListener 'hello', fn

        assert.equal false, events.emit 'hello'
        done null

      'registered by .once should only be called once': (done) ->
        events = new Events

        events.once 'hello', ->* 'Hello'
        events.emit 'hello'

        assert.equal false, events.emit 'hello'
        done null

