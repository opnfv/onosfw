#!/bin/bash
export GERRITROOT="$(pwd)"
export ONOSROOT=$GERRITROOT/framework/src/onos/
export BUILDROOT=$GERRITROOT/framework/build
export JAVA_HOME=/etc/alternatives/java_sdk
export ANT_HOME=$GERRITROOT/framework/build/ant/apache-ant-1.9.6
export M2_HOME=$GERRITROOT/framework/build/maven/build
export M2=$M2_HOME/bin
export PATH=$PATH:$ANT_HOME/bin:$M2:$JAVA_HOME/bin
