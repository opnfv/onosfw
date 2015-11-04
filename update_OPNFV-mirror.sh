#! /bin/bash

# update_OPNFV-mirror.sh
#
#
# Copyright 2015, Yunify, Inc. All rights reserved.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

##### Settings #####
VERSION=1.0.0
AUTHOR="Ashlee Young"
MODIFIED="November 3, 2015"
DEVROOT=$(pwd)
OPNFV_REPO=gerrit-onosfw
GITHUB_REPO=gerrit-mirror
GERRITURL=https://gerrit.opnfv.org/gerrit/onosfw
GITHUBURL=https://github.com/onosfw/gerrit-mirror
##### End Settings #####

##### Ask Function #####
ask()
{
    while true; do
        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
            fi
    # Ask the question
    read -p "$1 [$prompt] " REPLY
    # Default?
    if [ -z "$REPLY" ]; then
        REPLY=$default
    fi
    # Check if the reply is valid
    case "$REPLY" in
    Y*|y*) return 0 ;;
    N*|n*) return 1 ;;
    esac
    done
}
##### End Ask Function #####

##### Version #####
displayVersion()
{
    printf "You are running installer script Version: %s \n" "$VERSION"
    printf "Last modified on %s, by %s. \n\n" "$MODIFIED" "$AUTHOR"
}
##### End Version #####


setupRepos()
{
    # Check for OPNFV Gerrit Repo
    cd $DEVROOT
    if [ ! -d $OPNFV_REPO ]; then
  	    printf "Perhaps you've named it differently, but we don't see $OPNFV_REPO.\n"
  	    if ask "Would you like us to checkout ONOSFW from Gerrit?"; then
  		    git clone $GERRITURL
  	    fi
  	else
  		if ask "Would you like us to update your Gerrit Repo?"; then
  		    cd $DEVROOT/$OPNFV_REPO
  		    git pull
  		fi
    fi
    
    # Check for ONOSFW Mirror Repo
    cd $DEVROOT
    if [ ! -d $GITHUB_REPO ]; then
        printf "Perhaps you've named it differently, but we don't see $GITHUB_REPO.\n"
        if ask "Would you like us to checkout ONOSFW from Github?"; then
        	git clone $GITHUBURL
        fi
    else
    	if ask "Would you like us to update your Github Mirror?"; then
  		    cd $DEVROOT/$GITHUB_REPO
  		    git pull
  		fi
     fi
}

syncRepos()
{
	cd $DEVROOT
    rsync -arv --exclude=.git --exclude=.gitignore --exclude=.gitreview $OPNFV_REPO/ $GITHUB_REPO/
    cd $DEVROOT/$GITHUB_REPO/framework/build
    ls | grep -v README | xargs rm -rf
    cd $DEVROOT/$OPNFV_REPO
    lastCommit=$(git log -1 | grep commit | grep -v ONOS | awk '{print $2}')
    printf "Your local ONOSFW repo and mirror are now in sync.\n\n"
}

checkinMirror()
{
	if ask "Would you like to push the repo changes to Github?"; then
		cd $DEVROOT/$GITHUB_REPO
		git add --all .
		git commit -m \"Updating to Gerrit commit id $lastCommit\"
		git push
	fi
}

main()
{
	displayVersion
	setupRepos
	syncRepos
	checkinMirror
}

main
