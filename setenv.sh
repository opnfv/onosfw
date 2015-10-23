#!/bin/bash
export GERRITROOT="$(pwd)"
export ANT_HOME=$GERRITROOT/framework/src/ant/apache-ant-1.9.6
export M2_HOME=$GERRITROOT/framework/build/maven
export M2=$M2_HOME/bin
export PATH=$PATH:$ANT_HOME/bin:$M2
