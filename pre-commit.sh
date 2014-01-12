#!/bin/sh
#
# Test before committing.
#
# To enable this hook, rename this file to "pre-commit".
git stash -q --keep-index

# Test prospective commit
npm install
npm test

git stash pop -q

