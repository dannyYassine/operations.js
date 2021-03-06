#!/bin/sh

setup_git() {
  git config --global user.email "${ENV_EMAIL}"
  git config --global user.name "${TRAVIS_USERNAME}"
}

reset() {
  > _version.txt
}

build() {
  npm run build
}

update_version() {
  CURRENT_VERSION=$(node -p "require('./package.json').version")
  echo "$CURRENT_VERSION" >> scripts/_version.txt
}

commit_files() {
  git checkout master
  ls -al
  git status
  cd dist
  git add .
  cd ..
  ls -al
  git status
  git commit --message "[travis-ci skip] Travis build: ${TRAVIS_BUILD_NUMBER}; Updating operationkit.min.js"
}

upload_files() {
  git push "https://${ENV_GITHUB_USERNAME}:${ENV_GITHUB_PASSWORD}@github.com/dannyYassine/operationkit.git/"
}

setup_git
reset
build
update_version
commit_files
upload_files