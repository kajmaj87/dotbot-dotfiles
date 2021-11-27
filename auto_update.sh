#!/bin/bash

BRANCH="main"

START_DIR=$(pwd)
DOTFILES=~/.dotfiles

cd "$DOTFILES" || exit

if [[ `git status --porcelain` ]]; then
	echo "There are uncommited changes in $DOTFILES!"
fi


git remote update

# Were are we locally
LAST_UPDATE=$(git show --no-notes --format=format:"%H" $BRANCH | head -n 1)

# Were are we remote
LAST_COMMIT=$(git show --no-notes --format=format:"%H" origin/$BRANCH | head -n 1)

# IF we don't match we should update local
if [ "$LAST_COMMIT" != "$LAST_UPDATE" ]; then
        echo "Updating $DOTFILES from branch $BRANCH"
        git pull --no-edit
else
        echo "No updates in $DOTFILES available"
fi

cd "$START_DIR" || exit