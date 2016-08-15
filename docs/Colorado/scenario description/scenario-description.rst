=========================================
OPNFV Colorado release note for onosfw
=========================================

.. contents:: Table of Contents
   :backlinks: none


Abstract
========

This document describes the testing scenario of onosfw project, including ONOS bare metal and virtual deployment scenario

License
=======

<<<<<<< HEAD:docs/Colorado/scenario description/scenario-description.rst
OPNFV Colorado release note for onosfw Docs
=======
OPNFV Colorado release note for onosfw Docs
>>>>>>> 061216d... DOCS-84:docs/Colorado/scenario description/scenario-description.rst
(c) by Lucius (HUAWEI)

OPNFV Colorado release note for onosfw Docs
are licensed under a Creative Commons Attribution 4.0 International License.
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

Introduction
============

ONOSFW addresses integrating an SDN controller of choice based on a target applications or use cases within the OPNFV defined NFVI and VIM framework. 
In the Colorado release, in addition to the features in the Brahmaputra release, ONOSFW has included more functions in the Goldeneys of ONOS, and added service Function Chaining scenario by integrating the networking-sfc capability of openstack.
Therefore, both features and scenarios configurations are described.

ONOSFW Test Scenarios
=====================

Currently Openstack and ODL are using Centralized gateway to reach external network.ONOS takes a different approach, it uses DVR mode, where each compute node has the ability to reach external network, as illustrated below:

.. image::  /etc/ONOS-DVR.png


Secenario 14 ONOS-HA :
----------------------
1. L2 feature

   1.1 Infrastructure network setup; including CURD operation of bridge, interface, controller, port, etc.

   1.2 L2 traffic between different subnets in same network

   1.3 Traffic isolation between different tenants

2. L3 feature

   2.1 L3 east - west function

      2.1.1 Ping between VMs between differernt subnets belong to different tenants is OK

      2.1.2 isolated by different networks belong to differernt tenants is OK

      2.1.3 Related flow rule deleted when VM is deleted is OK

 

   2.2 L3 south - north function

      2.2.1. Ping external network (such as google) from VM by allocating a floating IP is OK

      2.2.2. Binding an external port to OVS is OK

      2.2.3. VM hot migration is supported

 

   2.3 Improvements

      2.3.1 Add p2any vxlan config to ovs is OK

      2.3.2. Ovsdb support multiple nodes is OK

      2.3.3. All nicira extension api has been extended

3. SFC feature

   3.1 Infrastructure CURD operation of SFC.

   3.2 traffic through SFC


Revision: _sha1_

:Author: Lucius(lukai1@huawei.com)

Build date: |today|
