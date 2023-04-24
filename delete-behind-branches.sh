#!/bin/bash

# Ensure that you're in a Git repository.
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Not a Git repository."
    exit 1
fi

# Fetch the latest information from the remote repository.
git fetch

# Get a list of remote branches, excluding "origin/HEAD -> origin/master"
remote_branches=$(git branch -r | grep -v "origin/HEAD")

# Iterate through the remote branches and delete those that are behind "develop" (except "master" and "release/*").
for branch in $remote_branches; do
    branch_name="${branch/origin\//}"
    if [[ "$branch_name" != "develop" && "$branch_name" != "master" && ! "$branch_name" =~ ^release/ ]]; then
        merge_base=$(git merge-base "origin/$branch_name" origin/develop)
        if [ "$(git rev-parse "origin/$branch_name")" = "$merge_base" ]; then
            echo "Deleting branch '$branch_name' as it is behind 'develop'"
            git push origin --delete "$branch_name"
        fi
    fi
done
