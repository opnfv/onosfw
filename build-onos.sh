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
VERSION=1.0.10
AUTHOR="Ashlee Young"
MODIFIED="December 21, 2015"
GERRITURL="git clone ssh://im2bz2pee@gerrit.opnfv.org:29418/onosfw"
ONOSURL="https://github.com/opennetworkinglab/onos"
SURICATAURL="https://github.com/inliniac/suricata"
ONOSGIT="git clone --recursive $ONOSURL"
JAVA_VERSION=1.8
ANT_VERSION=1.9.6
MAVEN_VERSION=3.3.3
KARAF_VERSION=4.0.2
LIBCAPNG_VERSION=0.7.7
COCCINELLE_VERSION=1.0.4
COCCINELLEURL=http://coccinelle.lip6.fr/distrib/coccinelle-$COCCINELLE_VERSION.tgz
OCAML_MAJOR=4
OCAML_MINOR=02
OCAML_SUB=3
OCAMLURL=http://caml.inria.fr/pub/distrib/ocaml-4.02/ocaml-$OCAML_MAJOR.$OCAML_MINOR.$OCAML_SUB.tar.gz
#MODE=$1

##### End Settings #####

##### Platform detection #####
detectOS()
{
    if [ -f "/etc/centos-release" ]; then
        export OS=centos
        export JAVA_HOME=/etc/alternatives/java_sdk
        export JRE_HOME=/etc/alternatives/java_sdk/bin
    elif [ -f "/etc/lsb-release" ]; then
        export OS=ubuntu
        export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
        export JRE_HOME=$JAVA_HOME/bin
    elif [[ -f "/etc/SuSE-release" ]]; then
        export OS=suse
        export JAVA_HOME=/usr/lib64/jvm/java-1.8.0-openjdk
        export JRE_HOME=$JAVA_HOME/bin
    else
        export OS=other
    fi
    java_tools=$(ls $JRE_HOME)
                for tool in $java_tools; do
                    alias "$tool=$JRE_HOME/$tool" 
                done
    printf "We have detected a derivitive OS of $OS.\n\n"
}
##### End Platform detection #####

##### Set build environment #####
export GERRITROOT="$(pwd)"
export BUILDROOT=$GERRITROOT/framework/build
export ONOSRC=$GERRITROOT/framework/src/onos
export ONOSROOT=$BUILDROOT/onos
export ONOS_ROOT=$BUILDROOT/onos
export ANT_HOME=$BUILDROOT/ant/apache-ant-1.9.6
export M2_HOME=$BUILDROOT/maven/build
export M2=$M2_HOME/bin
export PATH=$PATH:$ANT_HOME/bin:$M2:$JAVA_HOME/bin
export KARAF_ROOT=$BUILDROOT/karaf/$KARAF_VERSION
export ONOS_USER=root
export ONOS_GROUP=root
export ONOS_CELL=sdnds-tw
export RPMBUILDPATH=~/rpmbuild
export PATCHES=$GERRITROOT/framework/patches
export SURICATAROOT=$BUILDROOT/suricata
export SURICATASRC=$GERRITROOT/framework/src/suricata
export ONOSTAG=b209dc68e239009a9c1fdfe6fddeca0cf94fe9bf # 1.4.0-rc1 tag 

export ONOSFW_ROOT=`pwd`/framework/build
export M2_REPO=${M2_REPO:-~/.m2/repository}
export PATH="$PATH:$ONOS_ROOT/tools/dev/bin:$ONOS_ROOT/tools/test/bin"
export PATH="$PATH:$ONOS_ROOT/tools/build"
export BUILD_NUMBER=${BUILD_NUMBER:-$(id -un)~$(date +'%Y/%m/%d@%H:%M')}
export ONOS_POM_VERSION="1.4.0-rc1"
export ONOS_VERSION=${ONOS_VERSION:-1.3.0}
export ONOS_BITS=onos-${ONOS_VERSION%~*}
#export ONOS_STAGE_ROOT=`pwd`/framework/build/package
export ONOS_STAGE_ROOT=$1
export ONOS_STAGE=$ONOS_STAGE_ROOT/$ONOS_BITS
export ONOS_DEB_ROOT=$ONOS_STAGE_ROOT/deb
export ONOS_DEB=$ONOS_STAGE.deb
export ONOS_RPM_ROOT=$ONOS_STAGE_ROOT/rpm
export ONOS_RPM=$ONOS_STAGE.rpm
export ONOS_RPM_VERSION=${ONOS_POM_VERSION//-/.}
export ONOS_TAR=$ONOS_STAGE.tar.gz
export KARAF_VERSION=3.0.3
export KARAF_TAR=$ONOS_STAGE/apache-karaf-$KARAF_VERSION.tar.gz
export KARAF_DIST=apache-karaf-$KARAF_VERSION
export ONOS_TEST_BITS=onos-test-${ONOS_VERSION%~*}
export ONOS_TEST_STAGE_ROOT=${ONOS_TEST_STAGE_ROOT:-/tmp}
export ONOS_TEST_STAGE=$ONOS_STAGE_ROOT/$ONOS_TEST_BITS
export ONOS_TEST_TAR=$ONOS_TEST_STAGE.tar.gz
export ONOS_INSTALL_DIR="/opt/onos"     # Installation directory on remote
export OCI="${OCI:-192.168.56.101}"     # ONOS Controller Instance
export ONOS_USER="${ONOS_USER:-sdn}"    # ONOS user on remote system
export ONOS_GROUP="${ONOS_GROUP:-sdn}"  # ONOS group on remote system
export ONOS_PWD="rocks"                 # ONOS user password on remote system

##### End Set build environment #####

##### Version #####
displayVersion()
{
    clear
    printf "You are running installer script Version: %s \n" "$VERSION"
    printf "Last modified on %s, by %s. \n\n" "$MODIFIED" "$AUTHOR"
    sleep 1
}
##### End Version #####

##### Update ONOS #####
# This function will pull the ONOS upstream project and then update the 
# repository in this project with just the diffs.
updateONOS()
{
   # if [ "$MODE" != "auto" ]; then
   #     MODE=manual
   #     printf "NOTE: Updating upstream src is a PTL function. Please use this function locally, only. \n"
   #     printf "If you need the main repo updated to pick up ONOS upstream features, please email \n"
   #     printf "me at ashlee AT onosfw.com. \n\n"
   #     printf "Thanks! \n\n"
        freshONOS
        printf "\n"
        cd $BUILDROOT
        git clone $ONOSURL onosproject
        cd onosproject
        git checkout $ONOSTAG
        cd ../
        rsync -arvP --delete --exclude=.git --exclude=.gitignore --exclude=.gitreview onosproject/ ../src/onos/
        cd onosproject
        git log > ../onos_update.$(date +%s)
        cd ../
        #rm -rf onosproject
        cd $GERRITROOT
        # End applying patches
   # else
   #     MODE=auto
   # fi
   # printf "\n"
   # printf "Build Mode is set to $MODE\n\n"
}
##### End Update ONOS #####

##### Check Java  #####
checkJRE()
{
    if [ -d "$JRE_HOME" ]; then
        INSTALLED_JAVA=`$JRE_HOME/java -version 2>&1 | head -n 1 | cut -d\" -f 2`
        JAVA_NUM=`echo $INSTALLED_JAVA | awk -F "." '{print $1"."$2}'`
        if [ "$JAVA_NUM" '<' "$JAVA_VERSION" ]; then
            echo -e "Java version $INSTALLED_JAVA is lower than the required version of $JAVA_VERSION. \n"
            if [ "$OS" = "centos" ]; then
                printf "It is recommended that you run \"sudo yum -y install java-$JAVA_VERSION.0-openjdk-devel\".\n"
                sudo yum -y install java-$JAVA_VERSION.0-openjdk-devel
            elif [[ "$OS" = "ubuntu" ]]; then
                printf "It is recommended that you run \"sudo apt-get -y install openjdk-8-jdk\".\n"
                sudo add-apt-repository -y ppa:openjdk-r/ppa
                sudo apt-get -y update
                sudo apt-get -y install openjdk-8-jdk
        
            elif [[ "$OS" = "suse" ]]; then
                printf "It is recommended that you run \"sudo zypper --non-interactive install java-1_8_0-openjdk-devel\".\n"
                sudo zypper --non-interactive install java-1_8_0-openjdk-devel
            fi
        else
            printf "Installed Java version meets the requirements. \n\n"
        fi
    else
        printf "We are looking for Java in a specific location and not finding it. This won't change \n"
        printf "any other Java settings you might have. \n\n"
        if [ "$OS" = "centos" ]; then
            sudo yum -y install java-$JAVA_VERSION.0-openjdk-devel
        elif [[ "$OS" = "ubuntu" ]]; then
            sudo add-apt-repository -y ppa:openjdk-r/ppa
            sudo apt-get -y update
            sudo apt-get -y install openjdk-8-jdk
        elif [[ "$OS" = "suse" ]]; then
            sudo zypper --non-interactive install java-1_8_0-openjdk-devel
        fi
    fi
}

checkJDK()
{
    if [ ! -d "$JAVA_HOME" ]; then
        if [ "OS" = "centos" ]; then
            printf "It doesn't look there's a valid JDK installed.\n"
            sudo yum -y install java-$JAVA_VERSION.0-openjdk-devel
        elif [[ "$OS" = "ubuntu" ]]; then
            printf "It doesn't look there's a valid JDK installed.\n"
            sudo add-apt-repository -y ppa:openjdk-r/ppa
            sudo apt-get -y update
            sudo apt-get -y install openjdk-8-jdk
        elif [[ "$OS" = "suse" ]]; then
            printf "It doesn't look there's a valid JDK installed.\n"
            sudo zypper --non-interactive install java-1_8_0-openjdk-devel
        fi
    fi
}
##### End Check Java  #####

##### Install Ant #####
installAnt()
{
    if [ ! -d "$ANT_HOME/bin" ]; then 
        printf "You may have Ant installed on your system, but to avoid build issues, we'd like \n"
        printf "to use our own. It will be installed at $ANT_HOME. \n"
        if [ ! -d "$GERRITROOT/framework/build/ant" ]; then
            mkdir -p $GERRITROOT/framework/build/ant
            cd $GERRITROOT/framework/build/ant
            wget http://mirror.olnevhost.net/pub/apache/ant/source/apache-ant-$ANT_VERSION-src.tar.gz
            tar xzvf apache-ant-$ANT_VERSION-src.tar.gz
        fi
        cd $ANT_HOME
        sh build.sh install
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
        clear
        mkdir -p $GERRITROOT/framework/build/maven
        cd $GERRITROOT/framework/build/maven
        printf "Maven version $MAVEN_VERSION is being installed in: \n"
        printf "$GERRITROOT/framework/build/maven.\n\n"
        sleep 3
        wget http://archive.apache.org/dist/maven/maven-3/3.3.3/source/apache-maven-3.3.3-src.tar.gz
#        wget http://supergsego.com/apache/maven/maven-3/3.3.3/source/apache-maven-3.3.3-src.tar.gz
        tar xzvf apache-maven-3.3.3-src.tar.gz
        cd $GERRITROOT/framework/build/maven/apache-maven-$MAVEN_VERSION
        ant
        cd $GERRITROOT 
    else
        printf "Maven looks to be properly installed at $M2_HOME. \n\n"
    fi       
}
##### End Install Maven #####

##### Install karaf #####
installKaraf()
{
    if [ ! -d $KARAF_ROOT ]; then
        printf "While you may or may not have Karaf installed, our supported version is not yet installed.\n"
        clear
        mkdir -p $BUILDROOT/karaf/$KARAF_VERSION
        cd $KARAF_ROOT
        wget http://download.nextag.com/apache/karaf/$KARAF_VERSION/apache-karaf-$KARAF_VERSION-src.tar.gz
        tar xzvf apache-karaf-$KARAF_VERSION-src.tar.gz
        cd apache-karaf-$KARAF_VERSION
        mvn -Pfastinstall
    fi
}
##### End Install karaf #####

##### Delete ONOS Build #####
freshONOS()
{
    if [ -d $ONOSROOT ]; then
        printf "ONOS has previously been built.\n"
        rm -rf $ONOSROOT
    fi
}
##### End Delete ONOS Build #####

##### Build ONOS #####
buildONOS()
{
        updateONOS
        checkJRE
        checkJDK
        installAnt
        installMaven
        installKaraf
        freshONOS
        if [ ! -d $ONOSROOT ]; then
                clear
                mkdir -p $ONOSROOT
                cp -rv $ONOSRC/* $ONOSROOT/
                if [ -d $PATCHES/onos ]; then
                    cd $PATCHES
                    files=$(find . ! -path . -type f | grep -v 0) # Checks for any files in patches directory
                    if [ $"files" > 0 ]; then
                        for file in $files; do
                            FILEPATH=$(dirname $file) #isolate just the relative path so we can re-create it
                            if [ ! -d "$BUILDROOT/$FILEPATH" ]; then
                                mkdir -p $BUILDROOT/$FILEPATH #recreate the relative path
                            fi
                                cp -v $file $BUILDROOT/$FILEPATH/. #copy all files to proper location(s)
                        done
                    fi
                    cd $GERRITROOT
                fi
                cd $ONOSROOT
                ln -sf $KARAF_ROOT/apache-karaf-$KARAF_VERSION apache-karaf-$KARAF_VERSION
                mvn clean install
                if [ -f "$ONOSROOT/tools/build/envDefaults" ]; then
                    export ONOSVERSION="`cat $ONOSROOT/tools/build/envDefaults | grep "export ONOS_POM_VERSION" \
                    | awk -F "=" {'print $2'} | sed -e 's/^"//'  -e 's/"$//' |  awk -F "-" {'print $1'}`-onosfw-$(date +%s)"
                    printf "ONOSFW ONOS version is $ONOSVERSION. \n\n"
                fi
        else
                if [ -d $PATCHES/onos ]; then
                        cd $PATCHES
                        files=$(find . ! -path . -type f | grep -v 0) # Checks for any files in patches directory
                        if [ $"files" > 0 ]; then
                            for file in $files; do
                                FILEPATH=$(dirname $file) #isolate just the relative path so we can re-create it
                                if [ ! -d "$BUILDROOT/$FILEPATH" ]; then
                                    mkdir -p $BUILDROOT/$FILEPATH #recreate the relative path
                                fi
                                    cp -v $file $BUILDROOT/$FILEPATH/. #copy all files to proper location(s)
                            done
                        fi
                        cd $GERRITROOT
                fi
            cd $ONOSROOT
            ln -sf $KARAF_ROOT/apache-karaf-$KARAF_VERSION apache-karaf-$KARAF_VERSION
            mvn clean install  
            if [ -f "$ONOSROOT/tools/build/envDefaults" ]; then
                export ONOSVERSION="`cat $ONOSROOT/tools/build/envDefaults | grep "export ONOS_POM_VERSION" \
                | awk -F "=" {'print $2'} | sed -e 's/^"//'  -e 's/"$//' |  awk -F "-" {'print $1'}`-onosfw-$(date +%s)"
                printf "ONOSFW ONOS version is $ONOSVERSION. \n\n"
            fi
        fi 
}
##### End Build ONOS #####

##### Check for RPMBUILD tools #####
checkforRPMBUILD() # Checks whether RPMBUILD is installed
{
    if [ -z "$(command -v rpmbuild)" ]; then
            printf "RPM Development support is not installed. We need it to build the RPM packages. \n"
            if [ "$OS" = "centos" ]; then
                sudo yum -y install rpm-build
                sudo yum -y install rpm-devel
            elif [ "$OS" = "suse" ]; then
                sudo zypper --non-interactive install rpm-build
                sudo zypper --non-interactive install rpm-devel
            elif [ "$OS" = "ubuntu" ]; then
                sudo apt-get -y install rpm
            fi
    fi
}
##### End Check for RPMBUILD tools #####

##### Build Onos Package #####
buildPackage()
{
    $GERRITROOT/onos-package    
}
##### End Build Onos Package #####

##### Execution order #####
main()
{
    displayVersion
    detectOS
    buildONOS
    buildPackage
}
##### End Execution order #####

main # Launches the build process

