#!/bin/bash

set -e

cd lp-core/frontend
JSPM_BIN="jspm"
# Rebuild NPM if node_modules directory exists
NPM_REBUILD=false
if [ -d "node_modules" ]; then
    NPM_REBUILD=true
fi

# install required modules
echo ""
echo "*** Run NPM install"
NPM_INSTALL_START=$SECONDS
npm install
NPM_INSTALL_DURATION=$(( SECONDS - NPM_INSTALL_START ))
echo "*** NPM install completed in $NPM_INSTALL_DURATION seconds"

# Rebuild NPM modules
if [ "$NPM_REBUILD" == "true" ]; then
  echo "*** Rebuild NPM module bindings"
  NPM_REBUILD_START=$SECONDS
  npm rebuild node-sass
  NPM_REBUILD_DURATION=$(( SECONDS - NPM_REBUILD_START ))
  echo "*** NPM module rebuild completed in $NPM_REBUILD_DURATION seconds"
fi

# Now using salvador personal github account, needs to use company account.
$JSPM_BIN config registries.github.timeouts.lookup 60
$JSPM_BIN config registries.github.timeouts.build 120
$JSPM_BIN config registries.github.remote https://github.jspm.io
$JSPM_BIN config registries.github.maxRepoSize 0
$JSPM_BIN config registries.github.handler jspm-github

# Unencrypted Base64 encoding of your GitHub username and access token.
if [ -n "$GITHUB_ACCESS_TOKEN" ] && [ -n "$GITHUB_USERNAME" ]; then
  GITHUB_AUTH_TOKEN=$(echo -n "$GITHUB_USERNAME:$GITHUB_ACCESS_TOKEN" | base64)
  $JSPM_BIN config registries.github.auth $GITHUB_AUTH_TOKEN
fi

echo ""
echo "*** Run JSPM install"
JSPM_INSTALL_START=$SECONDS
$JSPM_BIN install
JSPM_INSTALL_DURATION=$(( SECONDS - JSPM_INSTALL_START ))
echo "*** JSPM install completed in $JSPM_INSTALL_DURATION seconds"

# run build
echo ""
echo "*** Run Gulp build"
GULP_BUILD_START=$SECONDS
npm run optimise
GULP_BUILD_DURATION=$(( SECONDS - GULP_BUILD_START ))
echo "*** Gulp build completed in $GULP_BUILD_DURATION seconds"
