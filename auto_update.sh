#!/usr/bin/env zsh

BRANCH="main"

START_DIR=$(pwd)
DOTFILES=~/.dotfiles

cd "$DOTFILES" || exit

git remote update

# Were are we locally
LAST_UPDATE=$(git show --no-notes --format=format:"%H" $BRANCH | head -n 1)

# Were are we remote
LAST_COMMIT=$(git show --no-notes --format=format:"%H" origin/$BRANCH | head -n 1)

# IF we don't match we should update local
if [ "$LAST_COMMIT" != "$LAST_UPDATE" ]; then
  echo "Updating $DOTFILES from branch $BRANCH"
  git pull --no-edit
  $DOTFILES/install
  omz reload
else
  echo "No updates in $DOTFILES available"
fi

if [[ `git status --porcelain` ]]; then
  # tput explained in: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
  echo "$(tput setaf 1)There are uncommited changes in $DOTFILES!"
  echo "$(tput setaf 1)$(tput smso)Commit and push changes."
  exit
fi

cd "$START_DIR" || exit
