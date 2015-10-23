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
MODIFIED="October 23, 2015"
GERRITURL="git clone ssh://im2bz2pee@gerrit.opnfv.org:29418/onosfw"
ONOSURL="https://github.com/opennetworkinglab/onos"
SURICATAURL="https://github.com/inliniac/suricata"
ONOSGIT="git clone --recursive $ONOSURL"
JAVA_VERSION=1.8
ANT_VERSION=1.9.6
MAVEN_VERSION=3.3.3
##### End Settings #####

##### Patches #####
PATCHES=$GERRITROOT/framework/patches
SOURCES=$GERRITROOT/framework/src
PATCH_PATH_1=onos/apps/vtn/vtnrsc/src/main/java/org/onosproject/vtnrsc/sfc
##### End Patches #####

##### Set build environment #####
export GERRITROOT="$(pwd)"
export ONOSROOT=$GERRITROOT/framework/src/onos/
export BUILDROOT=$GERRITROOT/framework/build
export JAVA_HOME=/etc/alternatives/java_sdk
export ANT_HOME=$GERRITROOT/framework/build/ant/apache-ant-1.9.6
export M2_HOME=$GERRITROOT/framework/build/maven/build
export M2=$M2_HOME/bin
export PATH=$PATH:$ANT_HOME/bin:$M2:$JAVA_HOME/bin
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
        # Begin applying patches
        mkdir -p framework/src/$PATCH_PATH_1
        cp $PATCHES/$PATCH_PATH_1/* $SOURCES/$PATCH_PATH_1/
        # End applying patches
    fi
    printf "\n"
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
        printf "Installed Java version meets the requirements. \n\n"
    fi    
}
##### End Check Java  #####

##### Install Ant #####
installAnt()
{
    if [ ! -d "$ANT_HOME/bin" ]; then 
        printf "You may have Ant installed on your system, but to avoid build issues, we'd like \n"
        printf "to use our own. It will be installed at $ANT_HOME. \n"
        if ask "May we proceed with installing ant here?"; then
            if [ ! -d "$GERRITROOT/framework/build/ant" ]; then
                mkdir -p $GERRITROOT/framework/build/ant
                cd $GERRITROOT/framework/build/ant
                wget http://mirror.olnevhost.net/pub/apache/ant/source/apache-ant-$ANT_VERSION-src.tar.gz
                tar xzvf apache-ant-$ANT_VERSION-src.tar.gz
            fi
            cd $ANT_HOME
            sh build.sh install
        fi
    else
        printf "Ant looks to be properly installed at $ANT_HOME. \n\n"
    fi
}
##### Install Ant #####

##### Install Maven #####
installMaven()
{
    if [ ! -d $M2_HOME ]; then
        printf "While you may or may not have Maven installed, our supported version is not yet installed.\n"
        if ask "May we install it?"; then
            clear
            mkdir -p $GERRITROOT/framework/build/maven
            cd $GERRITROOT/framework/build/maven
            printf "Maven version $MAVEN_VERSION is being installed in: \n"
            printf "$GERRITROOT/framework/build/maven.\n\n"
            sleep 3
            wget http://supergsego.com/apache/maven/maven-3/3.3.3/source/apache-maven-3.3.3-src.tar.gz
            tar xzvf apache-maven-3.3.3-src.tar.gz
            cd $GERRITROOT/framework/build/maven/apache-maven-$MAVEN_VERSION
            ant
            cd $GERRITROOT 
        fi
    else
        printf "Maven looks to be properly installed at $M2_HOME. \n\n"
    fi       
}
##### End Install Maven #####

##### Execution order #####
main()
{
    displayVersion
    updateONOS
    checkJAVA
    installAnt
    installMaven
}
##### End Execution order #####

main # Launches the build process