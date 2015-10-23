#!/bin/bash

# build.sh
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
MODIFIED="October 18, 2015"
GERRITURL="git clone ssh://im2bz2pee@gerrit.opnfv.org:29418/onosfw"
ONOSURL="https://github.com/opennetworkinglab/onos"
SURICATAURL="https://github.com/inliniac/suricata"
ONOSGIT="git clone --recursive $ONOSURL"
GERRITROOT="$(pwd)"
ONOSROOT=$GERRITROOT/framework/src/onos/
BUILDROOT=$GERRITROOT/framework/build
JAVA_VERSION=1.8
ANT_VERSION=1.9.6
MAVEN_VERSION=3.3.3
##### End Settings #####

##### Set build environment #####
source ./setenv.sh
##### End Set build environment #####

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

##### Update ONOS #####
# This function will pull the ONOS upstream project and then update the 
# repository in this project with just the diffs.
updateONOS()
{
	clear
    printf "This is mostly an admin function for the PTL, but you can use it to update your \n"
    printf "local copy. If you need the main repo updated to pick up ONOS upstream features, please email \n"
    printf "Ashlee at ashlee@onosfw.com. \n\n"
    printf "Thanks! \n\n"
    if ask "Do you still wish to update your local ONOS source tree?"; then
        printf "\n"
        cd $BUILDROOT
        git clone $ONOSURL onosproject
        rsync -arvP --delete --exclude=.git --exclude=.gitignore --exclude=.gitreview onosproject/ ../src/onos/
        cd onosproject
        git log > ../onos_update.$(date +%s)
        cd ../
        rm -rf onosproject
        cd $GERRITROOT
    fi
}
##### End Update ONOS #####

##### Check Java  #####
checkJAVA()
{
    INSTALLED_JAVA=`java -version 2>&1 | head -n 1 | cut -d\" -f 2` # | awk -F "." '{print $1"."$2}'`
    JAVA_NUM=`echo $INSTALLED_JAVA | awk -F "." '{print $1"."$2}'`
    if [ "$JAVA_NUM" '<' "$JAVA_VERSION" ]; then
        echo -e "Java version $INSTALLED_JAVA is lower than the required version of $JAVA_VERSION. \n"
        printf "It is recommended that you run \"sudo yum install java-$JAVA_VERSION.0-openjdk-devel\".\n"
        if ask "May we perform this task for you?"; then
            sudo yum install java-$JAVA_VERSION.0-openjdk-devel
        fi
    else
        printf "Installed Java version meets the requirements. \n"
    fi    
}
##### End Check Java  #####

##### Install Maven #####
installMaven()
{
    if [ ! -d $M2_HOME ]; then
        printf "While you may or may not have Maven installed, our supported version is not yet installed.\n"
        if ask "May we install it?"; then
            clear
            printf "Maven version $MAVEN_VERSION is being installed in: \n"
            printf "$GERRITROOT/framework/build/maven.\n\n"
            sleep 5
            cd $GERRITROOT/framework/src/maven/apache-maven-$MAVEN_VERSION
            ant
            cd $GERRITROOT 
        fi
    fi       
}
##### End Install Maven #####


displayVersion
updateONOS
checkJAVA
installMaven
