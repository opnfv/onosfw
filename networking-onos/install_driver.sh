#!/bin/bash

which neutron
#check neutron install on machine
if [ $? != 0 ]; then
    echo "Please install openstack neutron before install onos driver"
    exit
fi

cp /opt/networking-onos/mechanism_onos.py /usr/lib/python2.7/dist-packages/neutron/plugins/ml2/drivers/
cp /opt/networking-onos/ml2_conf_onos.ini /etc/neutron/plugins/ml2/
cp -f /opt/networking-onos/entry_points.txt /usr/lib/python2.7/dist-packages/neutron-2014.2.3.egg-info/
