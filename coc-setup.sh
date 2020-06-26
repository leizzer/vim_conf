#!/bin/sh

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
# Change arguments to extensions you need
yarn add coc-json coc-snippets coc-solargraph coc-tsserver coc-eslint coc-prettier coc-css coc-rls
