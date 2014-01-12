# TOC
   - [Co-events](#co-events)
     - [API](#co-events-api)
     - [Aliases](#co-events-aliases)
<a name=""></a>
 
<a name="co-events"></a>
# Co-events
<a name="co-events-api"></a>
## API
Listeners can be anything that co supports viz. promises, thunks, generators, arrays or objects..

```js
var e, events, fs;
events = new CoEvents;
fs = require('fs');
try {
  events.on('readFile', function*(filename) {
    return yield fs.readFile(filename);
  });
  return callback(null);
} catch (_error) {
  e = _error;
  return callback(e);
}
```

Listener called when event emitted.

```js
var events;
events = new CoEvents;
events.on('event', function*() {
  return callback(null);
});
return events.emit('event');
```

Arguments sent by emit are applied to listener.

```js
var events;
events = new CoEvents;
events.on('wait', function*(time) {
  yield wait(time);
  return callback(null);
});
return events.emit('wait', 500);
```

RemoveListener can remove attached listeners.

```js
var events, fn;
events = new CoEvents;
fn = function*() {
  return 'Hello';
};
events.on('hello', fn);
events.removeListener('hello', fn);
assert.equal(false, events.emit('hello'));
return callback(null);
```

Events registered using .once are removed once they are fired.

```js
var events;
events = new CoEvents;
events.once('hello', function*() {
  return 'Hello';
});
events.emit('hello');
assert.equal(false, events.emit('hello'));
return callback(null);
```

<a name="co-events-aliases"></a>
## Aliases
.off is an alias of .removeListener and .trigger is an alias of .emit.

```js
var events, fn;
events = new CoEvents;
fn = function*() {
  return 'Hello';
};
events.on('hello', fn);
events.trigger('hello');
events.off('hello', fn);
assert.equal(false, events.trigger('hello'));
return callback(null);
```

