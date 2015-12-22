#!/bin/bash

which neutron
#check neutron install on machine
if [ $? != 0 ]; then
    echo "Please install openstack neutron before install onos driver"
    exit
fi
export PBR_VERSION=1.0.0
/usr/bin/python setup.py install
