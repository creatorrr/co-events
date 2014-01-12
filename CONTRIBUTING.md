Guide for Contributors
======================

This library is available under the MIT license, contributions and improvements are encouraged.
Pull requests welcome!

Style guide
-----------

* The primary language used is `coffeescript`.
  It is concise, expressive and I like using it.

* Use just the right amount of comments.
  They should add to the readability of the code.

* All the code in the repository conforms to the [coffeescript-style-guide](http://github.com/polarmobile/coffeescript-style-guide).

Building
--------

* The code resides in `/src` and is compiled to `/lib` as javascript post install.
* Run `npm run-script build` to compile code to js. `watch` watches files for changes.
* Tests are in `/test` and can be run using `npm test`.
* Docs are generated from the tests by running `npm run-script docs`.

Patch guidelines
----------------

* Make sure to write good commit messages.
* Write tests for new features.
* Make sure all tests pass.
* Build docs.
* Add yourself to the list of contributors in `package.json` (if you havent already).
* Submit PR explaining the changes!
