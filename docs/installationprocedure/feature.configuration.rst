===========================================================================================================
ONOSFW Installation Guide for the OPNFV Danube Release
===========================================================================================================

.. contents:: Table of Contents
   :backlinks: none


Abstract
========

This document describes how to use various OPNFV installers to install and configure OPNFV Danube release with ONOS as the SDN controller.
It also outlines the system resource requirements, dependencies and limitations.

License
=======

Using Installers to Deploy ONOSFW for OPNFV Danube Release
(c) by Lucius (HUAWEI)

The Using Installers to Deploy ONOSFW for OPNFV Danube Release document
is licensed under a Creative Commons Attribution 4.0 International License.
You should have received a copy of the license along with this.
If not, see <http://creativecommons.org/licenses/by/4.0/>.

Version history
===============

+------------+----------+------------+------------------+
| **Date**   | **Ver.** | **Author** | **Comment**      |
|            |          |            |                  |
+------------+----------+------------+------------------+
| 2016-08-11 | 0.0.1    | Lucius     | First draft      |
|            |          | (HUAWEI)   |                  |
+------------+----------+------------+------------------+
| 2017-02-15 | 1.0.0    | Bob        | For Danube 1.0   |
|            |          | (HUAWEI)   |                  |
+------------+----------+------------+------------------+

Introduction
============

ONOSFW can be deployed on OPNFV Danube Releases using several installers. Each installer has its own system requirements and configuration procedures. The following table lists the basic system requirements when installing ONOSFW using each of the supported installers.

+-----------------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| Apex                                    | Compass                                 | Fuel                                    | JOID                                    |
+=========================================+=========================================+=========================================+=========================================+
| Virtual  CentOS 7,  ONOS with OpenStack | Virtual  Ubuntu 14, ONOS with OpenStack | Virtual  Ubuntu 14, ONOS with OpenStack | Virtual  Ubuntu 14, ONOS with OpenStack |
| neutron-l3-agent being disabled         | neutron-l3-agent being disabled         | neutron-l3-agent being disabled         | neutron-l3-agent being disabled         |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| NA                                      | BM  Ubuntu 14, ONOS with OpenStack      | NA                                      | NA                                      |
|                                         | neutron-l3-agent being disabled         |                                         |                                         |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+

Below are the detail configuration procedures for each installer:

Installer Configuration
=======================

Apex Configuration for ONOS
---------------------------
1. Resource Requirements

   1.1 CentOS 7 (from ISO or self-installed).

   1.2 Root access.

   1.3 libvirt virtualization support.

   1.4 minimum 2 networks and maximum 6 networks, multiple NIC and/or VLAN combinations are supported. This is virtualized for a VM deployment.

   1.5 The Danube Apex RPM.

   1.6 16 GB of RAM for a bare metal deployment, 56 GB of RAM for a VM deployment.

2. How to add ONOS into Apex

   2.1  Apex will download two images instack.qcow2 and overcloud-full.qcow2 to build Apex rpm. The instack.qcow2 is used for installation of instack virtual machine.
   The overcloud-full.qcow2 is used for installation of openstack nodes. The opnfv-tripleo-heat-templates.patch will update tripleo-heat scripts in instack.qcow2.
   And it will call puppet deployment scripts in overcloud-full.qcow2 to finish deployment. Those two files will be patch up and store into the two images during Apex rpm building process in instack.sh.

   Below is the directory Structure::

      ├── build
      │   ├── overcloud-onos.sh   # add ONOS build steps
      │   ├── opnfv-tripleo-heat-templates.patch   # add ONOS deployment scripts
      │
      ├── ci
      │   └── deploy.sh   #add ONOS build steps inside

   2.2 Upload puppet-onos to github for Apex iso/rpm building.

3. Virtual deployment

   3.1 Install jumphost.

   3.3 Execute sudo opnfv-deploy --virtual [ --no-ha ] -d /etc/opnfv-apex/os-onos-nofeature-ha.yaml -n /etc/opnfv-apex/network_settings.yaml

4. Baremetal deployment

   4.1 Install jumphost.

   4.3 Edit /etc/apex-opnfv/inventory.yaml and change mac_address, ipmi_ip, ipmi_user, ipmi_password etc base on your physical server and network.

   4.4 Execute sudo opnfv-deploy -d /etc/opnfv-apex/os-onos-nofeature-ha.yaml -i /etc/apex-opnfv/inventory.yaml -n /etc/opnfv-apex/network_settings.yaml

5. Detail of Apex installation `Apex Installation`_.

.. _Apex Installation : http://artifacts.opnfv.org/apex/docs/installation-instructions/


Compass Configuration for ONOS
------------------------------
1. Resource Requirements

   1.1 Ubuntu Server 14.04 LTS 64-bit (from ISO or self-installed).

   1.2 Minimum 2GB RAM.

   1.3 Minimum 2 processors.

   1.4 At least 5GB disk space.

   1.5 The ONOS version 1.4.

2. How to add ONOS into compass

   2.1 The ONOS installaion script is added into the compass4nfv project. and the onos will be started when compass calls the onos script. the script is included in the directory of compass4nfv project below::

      commpass4nfv
         ├── deploy
         │   ├── adapters
         │       ├── ansible
         │           ├── openstack_mitaka
         │               ├── roles # include the sdn script
         │                 ├── onos_cluster # include the ONOS script
         │                     ├── handlers # include the opertaion of restart ONOS service
         │                     ├── tasks # include the task of installing ONOS
         │                     ├── templates # include the templates of ONOS
         │                     ├── vars # include the var of ONOS used

3. Virtual deployment

   3.1 Install jumphost

   3.2 Build ISO image of compass. Execute ./build.sh

   3.3 If onos_sfc: Execute ./deploy.sh --dha /home/compass4nfv/deploy/conf/vm_environment/os-onos-nofeature-ha.yml \
                                        --network /home/compass4nfv/deploy/conf/vm_environment/huawei-virtual1/network_onos.yml \
                                        --iso-url file:///home/compass4nfv/work/building/compass.iso
       If onos_nofeature: Execute ./deploy.sh --dha /home/compass4nfv/deploy/conf/vm_environment/os-onos-sfc-ha.yml \
                                              --network /home/compass4nfv/deploy/conf/vm_environment/huawei-virtual1/network_onos.yml \
                                              --iso-url file:///home/compass4nfv/work/building/compass.iso

4. Baremetal deployment

   4.1 Install jumphost

   4.2 Build ISO image of compass. Execute ./build.sh

   4.3 Config the envionment variables

          export WORKSPACE="/home/jenkins/jenkins-slave/workspace/compass-deploy-bare-huawei-us-master"

          export BUILD_DIRECTORY=$WORKSPACE/build_output

          export CONFDIR=$WORKSPACE/deploy/conf/hardware_environment/huawei-pod1

          export ISO_URL=file://$BUILD_DIRECTORY/compass.iso

          export EXTERNAL_NIC=eth0

          export INSTALL_NIC=eth1

          export OS_VERSION=trusty

          export OPENSTACK_VERSION=mitaka

   4.4 Execute cd $WORKSPACE

   4.5 If onos_nofeature Execute ./deploy.sh --dha $CONFDIR/os-onos-nofeature-ha.yml --network $CONFDIR/network_onos.yml --iso-url file:///home/compass4nfv/work/building/compass.iso

   4.6 If onos_sfc Execute ./deploy.sh --dha $CONFDIR/os-onos-sfc-ha.yml --network $CONFDIR/network_onos.yml --iso-url file:///home/compass4nfv/work/building/compass.iso

5. For the details of compass installation `Compass Installation`_.

.. Compass Installation : http://artifacts.opnfv.org/compass4nfv/docs/configguide/installerconfig.html


Fuel Configuration for ONOS
---------------------------
1. Resource Requirement

   1.1 Linux , Microsoft or Mac OS.

   1.2 Root access or admin access.

   1.3 libvirt virtualization support.

   1.4 minimum 2 networks and maximum 4 networks, multiple NIC and/or VLAN combinations are supported.

   1.5 600G disk at least for no-ha virtual deployment

2. How to add ONOS into Fuel
   2.1 Fuel  provides an intuitive, GUI-driven experience for deployment and management of OpenStack, related community projects and plug-ins. Onos supplies plug-in to manage network of L2/L3 and SFC.
   below is the directory::

      ├── build
      │   ├──f_isoroot
      │       ├── f_onosfwpluginbuild   # add ONOS build url
      │
      ├── deploy
      │   ├──scenario
      │       ├── ha-onos_scenario.yaml   # add ONOS ha configuration
      │       ├── noha-onos_scenario.yaml   # add ONOS noha configuration
      │       ├── sfc-onos-ha_scenario.yaml   # add ONOS sfc ha configuration
      │       ├── sfc-onos-noha_scenario.yaml   # add ONOS sfc noha configuration
      ├── ci
      │   └── deploy.sh   #add ONOS scenarion steps inside

   2.2 Upload fuel-plugin-onos to git for fuel iso/rpm building.

3. Automatic deployment

   3.1 Install jumphost and download fuel.iso with ONOS plugin.

   3.2 git clone https://gerrit.opnfv.org/gerrit/fuel

   3.3 In fuel/ci, exec ./deploy.sh. For virtual deployment, you can use -b file:///fuel/deploy/config -l devel-popeline -p huawei-ch -s os-onos-sfc-ha -i file://root/iso/fuel.iso. \
       Fore bare metal deployment, modify dha.yaml according to hardware configuration.

4. Build ONOS plugin into rpm independently.

   4.1 Install fuel plugin builder( detailed steps can be found in https://wiki.openstack.org/wiki/Fuel/Plugin ).

   4.2 git clone git://git.openstack.org/openstack/fuel-plugin-onos. For Mitaka deployment, use –b Mitaka.

   4.3 fpb --build fuel-plugin-onos

   4.4 Move onos*.rpm in to master and fuel plugins –install onos*.rpm.

   4.5 Create a new environment and select onos plugin in settings table. As a constraint, you need to select public_network_assignment in network configuration. In addition, if you want to try SFC feature, select ''SFC feature'.

   4.6 Select a node with the role of controller and ONOS(ONOS must collocate with a controller).

   4.7 Deploy changes.

5. Related url for Fuel and ONOS.

   Fuel: https://wiki.openstack.org/wiki/Fuel

   Fuel plugin: https://wiki.openstack.org/wiki/Fuel/Plugins

   Fuel codes: https://gerrit.opnfv.org/gerrit/fuel

   Fuel iso: http://build.opnfv.org/artifacts/

   Fuel-plugin-onos: http://git.openstack.org/cgit/openstack/fuel-plugin-onos/


JOID Configuration for ONOS
---------------------------

1、Virtual Machine Deployment

   1.1、 Hardware Requirement:
       OS: Ubuntu Trusty 14.04 LTS

       Memory: 48 GB +

       CPU: 24 cores +

       Hard disk: 1T

   1.2、Get the joid code from gerrit https://gerrit.opnfv.org/gerrit/p/joid.git

   1.3、Suggest to create a user ubuntu and use this user, if not,you should edit the file：joid/ci/maas/default/deployment.yaml. Find Virsh power settings and change ubuntu to your own user name.

   1.4、Deploy Maas
      $ cd joid/ci/
      $ ./02-maasdeploy.sh

   1.5、Deploy OPNFV:
      For mitaka openstack, ONOS SDN, HA mode
     $ ./deploy.sh -o mitaka -s onos -t ha -f sfc -d trusty

2、Bare Metal Deployment

   2.1、Pre Requisite:

      1. have a single node install with Ubuntu OS 14.04 LTS

      2. Minimum four nodes are needed and they should be preconfigured and integrated with JOID, please refer to this wiki page https://wiki.opnfv.org/joid/get_started

   2.2、Get the joid code from gerrit : https://gerrit.opnfv.org/gerrit/p/joid.git

   2.3、Suggest to create a user ubuntu and use this user, if not,you should edit the file：joid/ci/maas/default/deployment.yaml.
     Find Virsh power settings and change ubuntu to your own user name.

   2.4、Deploy MAAS:

      $ ./02-maasdeploy.sh <lab and pod name i.e. intelpod5>

   2.5、Deploy OPNFV:

      For mitaka openstack, ONOS SDN, HA mode in intel pod5
      $ ./deploy.sh -o mitaka -s onos -t ha -f sfc -d trusty -l intelpod5

3、How to add ONOS into joid

create a dir ONOS as below::

   --onos
   ├── 01-deploybundle.sh  # deploy bundle define
   ├── juju-deployer
   │   ├── ovs-onos-ha.yaml # openstack type ha feature define
   │   ├── ovs-onos-nonha.yaml # openstack type nosha feature define
   │   ├── ovs-onos-tip.yaml # openstack type tip feature define
   ├── openstack.sh  # create ext-net
   ├── config_tpl/bundle_tpl
   │   ├── onos.yaml # set ONOS config option
   │   ├── subordinate.yaml # set openvswitch-onos config option
   └── README  # description

Revision: _sha1_

:Author: Lucius(lukai1@huawei.com)

Build date: |today|
