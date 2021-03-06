#!/bin/bash

# build.sh
#
#
# Copyright 2015-2016, Yunify, Inc. All rights reserved.
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
VERSION=1.0.15
AUTHOR="Ashlee Young"
MODIFIED="January 19, 2016"
GERRITURL="git clone ssh://im2bz2pee@gerrit.opnfv.org:29418/onosfw"
ONOSURL="https://github.com/opennetworkinglab/onos"
SURICATAURL="https://github.com/inliniac/suricata"
ONOSGIT="git clone --recursive $ONOSURL"
JAVA_VERSION=1.8
ANT_VERSION=1.9.6
MAVEN_VERSION=3.3.3
MAVENURL="http://mirrors.ibiblio.org/apache/maven/maven-3/$MAVEN_VERSION/source/apache-maven-$MAVEN_VERSION-src.tar.gz"
KARAF_VERSION=4.0.2
LIBCAPNG_VERSION=0.7.7
COCCINELLE_VERSION=1.0.4
COCCINELLEURL=http://coccinelle.lip6.fr/distrib/coccinelle-$COCCINELLE_VERSION.tgz
OCAML_MAJOR=4
OCAML_MINOR=02
OCAML_SUB=3
OCAMLURL=http://caml.inria.fr/pub/distrib/ocaml-4.02/ocaml-$OCAML_MAJOR.$OCAML_MINOR.$OCAML_SUB.tar.gz
MODE=$1
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
export ONOS_ROOT=$BUILDROOT/onos #Deprecated, don't use
export ONOS_STAGE_ROOT=$ONOSROOT/tmp
export ANT_HOME=$BUILDROOT/ant/apache-ant-1.9.6
export M2_HOME=$BUILDROOT/maven/build
export M2=$M2_HOME/bin
export PATH=$PATH:$ANT_HOME/bin:$M2:$JAVA_HOME/bin
export KARAF_ROOT=$BUILDROOT/karaf/$KARAF_VERSION
export ONOSTARDIR=$ONOSROOT/tar_dir
export KARAF_TAR=$KARAF_ROOT/apache-karaf-$KARAF_VERSION/assemblies/apache-karaf/target/apache-karaf-$KARAF_VERSION.tar.gz
export ONOS_USER=root
export ONOS_GROUP=root
export ONOS_CELL=sdnds-tw
export RPMBUILDPATH=~/rpmbuild
export PATCHES=$GERRITROOT/framework/patches
export SURICATAROOT=$BUILDROOT/suricata
export SURICATASRC=$GERRITROOT/framework/src/suricata
export ONOSTAG=b209dc68e239009a9c1fdfe6fddeca0cf94fe9bf # 1.4.0-rc1 tag 
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
        if [ "$MODE" = "auto" ]; then
            REPLY="Y"
        else
            read -p "$1 [$prompt] " REPLY
        fi
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
    if [ "$MODE" != "auto" ]; then
        MODE=manual
        if ask "Would you like to refresh your ONOS src tree with the ONOS tip?"; then
            printf "NOTE: Updating upstream src is a PTL function. Please use this function locally, only. \n"
            printf "If you need the main repo updated to pick up ONOS upstream features, please email \n"
            printf "me at ashlee AT onosfw.com. \n\n"
            printf "Thanks! \n\n"
            if ask "Do you still wish to update your local ONOS source tree?"; then
                freshONOS
                printf "\n"
                cd $BUILDROOT
                git clone $ONOSURL onosproject
                cd onosproject
                git checkout $ONOSTAG
                cd ../
                rsync -arP --delete --exclude=.git --exclude=.gitignore --exclude=.gitreview onosproject/ ../src/onos/
                cd onosproject
                git log > ../onos_update.$(date +%s)
                cd ../
                #rm -rf onosproject
                cd $GERRITROOT
                # End applying patches
            fi
        fi
    else
        MODE=auto
    fi
    printf "\n"
    printf "Build Mode is set to $MODE\n\n"
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
                if ask "May we perform this task for you?"; then
                    sudo yum -y install java-$JAVA_VERSION.0-openjdk-devel
                fi
            elif [[ "$OS" = "ubuntu" ]]; then
                printf "It is recommended that you run \"sudo apt-get -y install openjdk-8-jdk\".\n"
                if ask "May we perform this task for you?"; then
                    sudo add-apt-repository -y ppa:openjdk-r/ppa
                    sudo apt-get -y update
                    sudo apt-get -y install openjdk-8-jdk
                fi
        
            elif [[ "$OS" = "suse" ]]; then
                printf "It is recommended that you run \"sudo zypper --non-interactive install java-1_8_0-openjdk-devel\".\n"
                if ask "May we perform this task for you?"; then
                    sudo zypper --non-interactive install java-1_8_0-openjdk-devel
                fi
            fi
        else
            printf "Installed Java version meets the requirements. \n\n"
        fi
    else
        printf "We are looking for Java in a specific location and not finding it. This won't change \n"
        printf "any other Java settings you might have. \n\n"
        if ask "May we install it where we need it?"; then
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
    fi
}

checkJDK()
{
    if [ ! -d "$JAVA_HOME" ]; then
        if [ "OS" = "centos" ]; then
            printf "It doesn't look there's a valid JDK installed.\n"
            if ask "May we install one?"; then
                sudo yum -y install java-$JAVA_VERSION.0-openjdk-devel
            else
                printf "You should run \"sudo yum -y install java-$JAVA_VERSION.0-openjdk-devel\". \n\n"
            fi
        elif [[ "$OS" = "ubuntu" ]]; then
            printf "It doesn't look there's a valid JDK installed.\n"
            if ask "May we install one?"; then
                sudo add-apt-repository -y ppa:openjdk-r/ppa
                sudo apt-get -y update
                sudo apt-get -y install openjdk-8-jdk
            else
                printf "You should run \"sudo apt-get -y install openjdk-8-jdk\". \n\n"
            fi
        elif [[ "$OS" = "suse" ]]; then
            printf "It doesn't look there's a valid JDK installed.\n"
            if ask "May we install one?"; then
                sudo zypper --non-interactive install java-1_8_0-openjdk-devel
            else
                printf "You should run \"sudo zypper --non-interactive install java-1_8_0-openjdk-devel\". \n\n"
            fi
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
            wget $MAVENURL
            tar xzvf apache-maven-$MAVEN_VERSION-src.tar.gz
            cd $GERRITROOT/framework/build/maven/apache-maven-$MAVEN_VERSION
            ant
            cd $GERRITROOT 
        fi
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
        if ask "May we install it?"; then
            clear
            mkdir -p $BUILDROOT/karaf/$KARAF_VERSION
            cd $KARAF_ROOT
            wget http://download.nextag.com/apache/karaf/$KARAF_VERSION/apache-karaf-$KARAF_VERSION-src.tar.gz
            tar xzvf apache-karaf-$KARAF_VERSION-src.tar.gz
            cd apache-karaf-$KARAF_VERSION
            mvn -Pfastinstall
        fi
    fi
}
##### End Install karaf #####

##### Delete ONOS Build #####
freshONOS()
{
    if [ -d $ONOSROOT ]; then
        printf "ONOS has previously been built.\n"
            if ask "Would you like to build fresh? This involves deleting the old build."; then
                rm -rf $ONOSROOT
            fi
    fi
}
##### End Delete ONOS Build #####

##### Build ONOS #####
buildONOS()
{
    if ask "Would you like to build ONOS?"; then
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
                cp -r $ONOSRC/* $ONOSROOT/
                if [ -d $PATCHES/onos ]; then
                    if ask "Would you like to apply ONOSFW unique patches?"; then
                        cd $PATCHES
                        files=$(find . ! -path . -type f | grep -v 0) # Checks for any files in patches directory
                        if [ $"files" > 0 ]; then
                            for file in $files; do
                                FILEPATH=$(dirname $file) #isolate just the relative path so we can re-create it
                                if [ ! -d "$BUILDROOT/$FILEPATH" ]; then
                                    mkdir -p $BUILDROOT/$FILEPATH #recreate the relative path
                                fi
                                    cp $file $BUILDROOT/$FILEPATH/. #copy all files to proper location(s)
                            done
                        fi
                        cd $GERRITROOT
                    fi
                fi
                cd $ONOSROOT
                ln -sf $KARAF_ROOT/apache-karaf-$KARAF_VERSION apache-karaf-$KARAF_VERSION
                mvn clean install
                if [ -f "$ONOSROOT/tools/build/envDefaults" ]; then
                    export ONOSVERSION="`cat $ONOSROOT/tools/build/envDefaults | grep "export ONOS_POM_VERSION" \
                    | awk -F "=" {'print $2'} | sed -e 's/^"//'  -e 's/"$//' |  awk -F "-" {'print $1'}`-onosfw-$(date +%s)"
                    printf "ONOSFW ONOS version is $ONOSVERSION. \n\n"
                    buildONOSTar
                fi
        else
            if ask "There looks to be a previous build. Would you like us to re-build ONOS?"; then
                if [ -d $PATCHES/onos ]; then
                    if ask "Would you like to apply ONOSFW unique patches?"; then
                        cd $PATCHES
                        files=$(find . ! -path . -type f | grep -v 0) # Checks for any files in patches directory
                        if [ $"files" > 0 ]; then
                            for file in $files; do
                                FILEPATH=$(dirname $file) #isolate just the relative path so we can re-create it
                                if [ ! -d "$BUILDROOT/$FILEPATH" ]; then
                                    mkdir -p $BUILDROOT/$FILEPATH #recreate the relative path
                                fi
                                    cp $file $BUILDROOT/$FILEPATH/. #copy all files to proper location(s)
                            done
                        fi
                        cd $GERRITROOT
                    fi
                fi
            fi
            cd $ONOSROOT
            ln -sf $KARAF_ROOT/apache-karaf-$KARAF_VERSION apache-karaf-$KARAF_VERSION
            mvn clean install
            if [ -f "$ONOSROOT/tools/build/envDefaults" ]; then
                export ONOSVERSION="`cat $ONOSROOT/tools/build/envDefaults | grep "export ONOS_POM_VERSION" \
                | awk -F "=" {'print $2'} | sed -e 's/^"//'  -e 's/"$//' |  awk -F "-" {'print $1'}`-onosfw-$(date +%s)"
                printf "ONOSFW ONOS version is $ONOSVERSION. \n\n"
                buildONOSTar
            fi
        fi 
    fi 
}
##### End Build ONOS #####

##### Check for RPMBUILD tools #####
checkforRPMBUILD() # Checks whether RPMBUILD is installed
{
    if [ -z "$(command -v rpmbuild)" ]; then
            printf "RPM Development support is not installed. We need it to build the RPM packages. \n"
            if ask "May we install it?"; then
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
    fi
}
##### End Check for RPMBUILD tools #####

##### Build ONOS compressed package #####
buildONOSTar() 
{
	export ONOSVERSION="`cat $ONOSROOT/tools/build/envDefaults | grep "export ONOS_POM_VERSION" \
                    | awk -F "=" {'print $2'} | sed -e 's/^"//'  -e 's/"$//' |  awk -F "-" {'print $1'}`-onosfw-$(date +%s)"
                    printf "ONOSFW ONOS version is $ONOSVERSION. \n\n"
	if [ -d "$ONOSTARDIR" ]; then
		rm -rf $ONOSTARDIR
	fi
	mkdir $ONOSTARDIR
	cd $ONOSTARDIR
	mkdir onos-$ONOSVERSION
	cp -r $ONOSROOT/apps onos-$ONOSVERSION/.
	cp -r $ONOSROOT/tools/package/bin onos-$ONOSVERSION/.
	cp -r $ONOSROOT/tools/package/init onos-$ONOSVERSION/.
	find . -name *.java | xargs rm -f
	echo $ONOSVERSION > onos-$ONOSVERSION/VERSION
	tar xzf $KARAF_TAR -C onos-$ONOSVERSION
	tar czf onos-$ONOSVERSION.tar.gz onos-$ONOSVERSION
	cd $GERRITROOT
}
##### End Build ONOS compressed package #####

##### Update Suricata #####
# This function will pull the Suricata upstream project and then update the 
# repository in this project with just the diffs.
updateSuricata()
{
    if [ "$MODE" != "auto" ]; then
        printf "NOTE: Updating upstream src is a PTL function. Please use this function locally, only. \n"
        printf "If you need the main repo updated to pick up ONOS upstream features, please email \n"
        printf "me at ashlee AT onosfw.com. \n\n"
        printf "Thanks! \n\n"
        if ask "Do you still wish to update your local Suricata source tree?"; then
            freshSuricata
            printf "\n"
            cd $BUILDROOT
            git clone $SURICATAURL suricataproject
            rsync -arP --delete --exclude=.git --exclude=.gitignore --exclude=.gitreview suricataproject/ ../src/suricata/
            cd suricataproject
            git log > ../suricata_update.$(date +%s)
            cd ../
            rm -rf suricataproject
            cd $GERRITROOT
            # End applying patches
        fi
    fi
    printf "\n"
    printf "Build Mode is set to $MODE\n\n"
}
##### End Update Suricata #####

##### Delete Suricata Build #####
freshSuricata()
{
    if [ -d $SURICATAROOT ]; then
        printf "Suricata has previously been built.\n"
            if ask "Would you like to build fresh? This involves deleting the old build."; then
                rm -rf $SURICATAROOT
            fi
    fi
}
##### End Delete Suricata Build #####

##### Check for Suricata Dependencies #####
suricataDepends() # Checks whether dependencies are installed
{
    if [ "$OS" = "centos" ]; then
       sudo yum -y install libpcap libpcap-devel libnet libnet-devel pcre pcre-devel gcc gcc-c++ \
           automake autoconf libtool make libyaml libyaml-devel zlib zlib-devel libcap-ng-devel file-devel
    elif [ "$OS" = "suse" ]; then
       sudo zypper --non-interactive install libpcap-devel libnet-devel pcre-devel gcc gcc-c++ \
           automake autoconf libtool make libyaml-devel zlib-devel libcap-ng-devel file-devel
    elif [ "$OS" = "ubuntu" ]; then
        sudo apt-get -y install libpcre3 libpcre3-dbg libpcre3-dev \
            build-essential autoconf automake libtool libpcap-dev libnet1-dev \
            libyaml-0-2 libyaml-dev pkg-config zlib1g zlib1g-dev libcap-ng-dev libcap-ng0 \
            make libmagic-dev libnetfilter-queue-dev libnetfilter-queue1 libnfnetlink-dev \
            libnfnetlink0
    fi   
}
##### End Check for Suricata Dependencies #####

##### Build Suricata #####
buildSuricata()
{
    if ask "Would you like to build Suricata for DPI capabilities?"; then
        updateSuricata
        freshSuricata
        if [ ! -d $SURICATAROOT ]; then
            if ask "May we proceed to build Suricata?"; then
                clear
                mkdir -p $SURICATAROOT
                cp -r $SURICATASRC/* $SURICATAROOT/
                if [ -d $PATCHES/suricata ]; then
                    if ask "Would you like to apply ONOSFW unique patches?"; then
                        cd $PATCHES
                        files=$(find . ! -path . -type f | grep -v 0) # Checks for any files in patches directory
                        if [ $"files" > 0 ]; then
  							for file in $files; do
                                FILEPATH=$(dirname $file) #isolate just the relative path so we can re-create it
                                if [ ! -d "$BUILDROOT/$FILEPATH" ]; then
                                    mkdir -p $BUILDROOT/$FILEPATH #recreate the relative path
                                fi
                                    cp $file $BUILDROOT/$FILEPATH/. #copy all files to proper location(s)
                            done
                        fi
                        cd $GERRITROOT
                    fi
                fi
                cd $SURICATAROOT
                git clone https://github.com/OISF/libhtp.git -b 0.5.x
                ./autogen.sh
                ./configure
                make
                cd $GERRITROOT
            fi
        else
            if ask "Would you like us to re-run building Suricata?"; then
                if [ -d $PATCHES/suricata ]; then
                    if ask "Would you like to apply ONOSFW unique patches?"; then
                        cd $PATCHES
                        files=$(find . ! -path . -type f | grep -v 0) # Checks for any files in patches directory
                        if [ $"files" > 0 ]; then
                            for file in $files; do
                                FILEPATH=$(dirname $file) #isolate just the relative path so we can re-create it
                                if [ ! -d "$BUILDROOT/$FILEPATH" ]; then
                                    mkdir -p $BUILDROOT/$FILEPATH #recreate the relative path
                                fi
                                    cp $file $BUILDROOT/$FILEPATH/. #copy all files to proper location(s)
                            done
                        fi
                        cd $GERRITROOT
                    fi
                fi
                cd $SURICATAROOT
                git clone https://github.com/OISF/libhtp.git -b 0.5.x
                ./autogen.sh
                ./configure
                make
                cd $GERRITROOT
            fi  
        fi
    fi
}
##### End Build Suricata #####

##### Execution order #####
main()
{
    displayVersion
    detectOS
    buildONOS
}
##### End Execution order #####

main # Launches the build process

