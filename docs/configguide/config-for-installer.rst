===========================================================================================================
OPNFV config guide instructions for the Brahmaputra release of OPNFV when using installers to deploy onosfw
===========================================================================================================

.. contents:: Table of Contents
   :backlinks: none


Abstract
========

This document describes how to config the Brahmaputra release of OPNFV when
using installers as a deployment tool to deploy onosfw, covering it's limitations, dependencies
and required system resources.

License
=======

Brahmaputra release of OPNFV when using installers to deploy onosfw Docs
(c) by Henry (HUAWEI)

Brahmaputra release of OPNFV when using installers to deploy onosfw Docs
are licensed under a Creative Commons Attribution 4.0 International License.
You should have received a copy of the license along with this.
If not, see <http://creativecommons.org/licenses/by/4.0/>.

Version history
===============

+------------+----------+------------+------------------+
| **Date**   | **Ver.** | **Author** | **Comment**      |
|            |          |            |                  |
+------------+----------+------------+------------------+
| 2016-01-21 | 1.0.0    | Henry      | Rewritten for    |
|            |          | (HUAWEI)   | ONOSFW B release |
+------------+----------+------------+------------------+
| 2016-01-20 | 0.0.2    | Henry      | Minor changes &  |
|            |          | (HUAWEI)   | formatting       |
+------------+----------+------------+------------------+
| 2016-01-19 | 0.0.1    | Henry      | First draft      |
|            |          | (HUAWEI)   |                  |
+------------+----------+------------+------------------+

Introduction
============

ONOSFW need to deploy with several installers and each installer have differernt configs. Here is the scenarios ONOSFW need to supported

+-----------------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| Apex                                    | Compass                                 | Fuel                                    | JOID                                    |
+=========================================+=========================================+=========================================+=========================================+
| Virtual  CentOS 7,  ONOS with OpenStack | Virtual  Ubuntu 14, ONOS with OpenStack | Virtual  Ubuntu 14, ONOS with OpenStack | Virtual  Ubuntu 14, ONOS with OpenStack |
| neutron-l3-agent being disabled         | neutron-l3-agent being disabled         | neutron-l3-agent being disabled         | neutron-l3-agent being disabled         |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
| NA                                      | BM  Ubuntu 14, ONOS with OpenStack      | NA                                      | NA                                      |
|                                         | neutron-l3-agent being disabled         |                                         |                                         |
+-----------------------------------------+-----------------------------------------+-----------------------------------------+-----------------------------------------+
Below is the detail config for them:

Config for Installers
=====================

Config Documentation for onos with apex
---------------------------------------
1. Pyhsical Requirement

   1.1 CentOS 7 (from ISO or self-installed).
   
   1.2 Root access.
   
   1.3 libvirt virtualization support.
   
   1.4 minimum 2 networks and maximum 6 networks, multiple NIC and/or VLAN combinations are supported. This is virtualized for a VM deployment.
   
   1.5 The Bramaputra Apex RPM.
   
   1.6 16 GB of RAM for a bare metal deployment, 56 GB of RAM for a VM deployment.
 
2. How to add onos into apex

   2.1  Apex will download two images instack.qcow2 and overcloud-full.qcow2 when build apex rpm. The instack.qcow2 is used for installation of instack virtual machine.
   The overcloud-full.qcow2 is used for installation of openstack nodes. The opnfv-tripleo-heat-templates.patch will update tripleo-heat scripts in instack.qcow2.
   And it will call puppet deployment scripts in overcloud-full.qcow2 to finish deployment. Those two files will be patch up and store into the two images during apex rpm building process in instack.sh.

   below is the directory::

      ├── build
      │   ├── instack.sh   # add onos build steps
      │   ├── opnfv-tripleo-heat-templates.patch   # add onos deployment scripts
      │   
      ├── ci
      │   └── deploy.sh   #add onos build steps inside

   2.2 Upload puppet-onos to github for apex iso/rpm building.

3. Virtual deployment 

   3.1 Install jumphost.
   
   3.2 Edit /etc/opnfv-apex/deploy_settings.yaml and change opendaylight into onos.
   
   3.3 Execute sudo opnfv-deploy --virtual [ --no-ha ] -d /etc/opnfv-apex/deploy_settings.yaml

4. Baremetal deployment

   4.1 Install jumphost.
   
   4.2 Edit /etc/opnfv-apex/deploy_settings.yaml and change opendaylight into onos.
   
   4.3 Edit /etc/apex-opnfv/inventory.yaml and change mac_address, ipmi_ip, ipmi_user, ipmi_password etc base on your physical server and network.
   
   4.4 Execute sudo opnfv-deploy -d /etc/opnfv-apex/deploy_settings.yaml -i /etc/apex-opnfv/inventory.yaml

5. Detail of apex installation `Apex Installation`_.

.. _Apex Installation : http://artifacts.opnfv.org/apex/docs/installation-instructions/
   
Config Documentation for onos with Compass
------------------------------------------

Contents:

Config Documentation for onos with Fuel
---------------------------------------

Contents:

Config Documentation for onos with JOID
---------------------------------------

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
      For liberty openstack, ONOS SDN, HA mode
     $ ./deploy.sh -o liberty -s onos -t ha

2、Bare Metal Deployment

   2.1、Pre Requisite:
   
      1. have a single node install with Ubuntu OS 14.04 LTS
      
      2. Minimum four nodes exist and should have been preconfigured and integrated with JOID please have look into this wiki page https://wiki.opnfv.org/joid/get_started
      
   2.2、Get the joid code from gerrit : https://gerrit.opnfv.org/gerrit/p/joid.git
   
   2.3、Suggest to create a user ubuntu and use this user, if not,you should edit the file：joid/ci/maas/default/deployment.yaml.
     Find Virsh power settings and change ubuntu to your own user name.
     
   2.4、Deploy MAAS:
   
      $ ./02-maasdeploy.sh <lab and pod name i.e. intelpod5>
      
   2.5、Deploy OPNFV:
   
      For liberty openstack, ONOS SDN, HA mode in intel pod5
      $ ./deploy.sh -o liberty -s onos -t ha -l intelpod5

3、How to add onos into joid

create a dir onos as below::

   --onos
   ├── 01-deploybundle.sh  # deploy bundle define
   ├── juju-deployer
   │   ├── ovs-onos-ha.yaml # openstack type ha feature define
   │   ├── ovs-onos-nonha.yaml # openstack type nosha feature define
   │   ├── ovs-onos-tip.yaml # openstack type tip feature define
   ├── juju_test_prepare.sh  # create ext-net and update gw_mac
   └── README  # description

Revision: _sha1_

:Author: Henry(jiangrui1@huawei.com)

Build date: |today|
