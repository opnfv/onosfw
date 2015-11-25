#!/bin/bash

# setenv.sh
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


export GERRITROOT="$(pwd)"
export ONOSROOT=$GERRITROOT/framework/src/onos/
export BUILDROOT=$GERRITROOT/framework/build
export JAVA_HOME=/etc/alternatives/java_sdk
export ANT_HOME=$GERRITROOT/framework/build/ant/apache-ant-1.9.6
export M2_HOME=$GERRITROOT/framework/build/maven/build
export M2=$M2_HOME/bin
export PATH=$PATH:$ANT_HOME/bin:$M2:$JAVA_HOME/bin
