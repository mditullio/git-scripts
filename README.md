# git-scripts

## delete-behind-branches.sh

his script will first check if you're in a Git repository. 
If not, it will print an error message and exit. 
It will then fetch the latest information from the remote repository and list all remote branches. 
It will iterate through the branches and compare their merge-base with the "develop" branch. 
If the branch is behind "develop", it will delete it from the remote repository, except for the "develop", "master" and "release/*" branches.

Please note that this script will delete branches from the remote repository without confirmation, so use it with caution. 
Make sure you have a backup of your repository or the branches you want to keep before running this script.

Useful links

- https://git-scm.com/docs/git-merge-base
- https://git-scm.com/docs/git-rev-parse
