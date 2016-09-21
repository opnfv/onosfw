=================
ONOSFW User Guide
=================

.. contents:: Table of Contents
   :backlinks: none


Abstract
========

This document describes the user guide instruction for onosfw project, including env setup and test case.

License
=======

.. This work is licensed under a Creative Commons Attribution 4.0 International License.
.. http://creativecommons.org/licenses/by/4.0
.. (c) Lucius (HUAWEI)

Version history
===============

+------------+----------+------------+------------------+
| **Date**   | **Ver.** | **Author** | **Comment**      |
|            |          |            |                  |
+------------+----------+------------+------------------+
| 2016-01-21 | 1.0.0    | Lucius     | Rewritten for    |
|            |          | (HUAWEI)   | ONOSFW C release |
+------------+----------+------------+------------------+

Introduction
============

    ONOSFW addresses integrating an SDN controller of choice based on a target applications or use cases within the OPNFV defined NFVI and VIM framework.
    In the Colorado release, in addition to the features in the Brahmaputra release, ONOSFW has included more functions in the Goldeneys of ONOS, 
and added service Function Chaining scenario by integrating the networking-sfc capability of openstack.Therefore, both features and scenarios configurations are described.

ONOSFW User Guide Manaully
==========================

ONOSFW Environment Setup
------------------------
 1. initialize environment::

   initialize openstack：delete allthe network, instance and router.

   initialize ovs：delete managerand bridge by the following command：

   ovs-vsctl  del-manager

   ovs-vsctl del-br “bridge name”

 2. restart ONOS，install feature::

   feature:install onos-openflow-base

   feature:install onos-openflow

   feature:install onos-ovsdatabase

   feature:install onos-ovsdb-base

   feature:install onos-drivers-ovsdb

   feature:install onos-ovsdb-provider-host

   feature:install onos-app-vtn-onosfw

 3. set the external port name::

   ONOS command：externalportname-set –n “external port name”

 4. create provider network::

   set manager on compute node and network node: ovs-vsctl set-manager tcp:“onos ip”:6640

 5. create basic networks and instances on openstack dashboard to verify L2/L3 function

 6. create basic scenarios to verify SFC functions.

Scenario Supported
------------------

* L2 scene:

   * Live Migration

   * With between same node under the same tenant and network wether the vm is conneted

   * With between different nodes under the same tenant and network wether the vm is conneted

   * With between same node under the same tenant and different network wether the vm is not conneted

   * With between different nodes under the same tenant and different network wether the vm is not conneted

   * With between same nodes under the different tenant and different network wether the vm is not conneted

   * With between different nodes under the different tenant and different network wether the vm is not conneted

 * L3 scene:

   * With between same node under the same tenant and network wether the vm is conneted

   * With between different nodes under the same tenant and network wether the vm is conneted

   * With between same node under the same tenant and different network wether the vm is conneted

   * With between different nodes under the same tenant and different network wether the vm is conneted

   * With between same nodes under the different tenant and different network wether the vm is not conneted

   * With between different nodes under the different tenant and different network wether the vm is not conneted
   VM can ping external network well

 * SFC scene:

   * Create 3-4 VNF-nodes service chain, verify with traffic

   * Remove service chain, display service chain info

   * Insert a node(vnf) in the chain, and verify with traffic

   * Remove a node from the chain and verify with traffic

   * Get service chain status

ONOSFW Demo Video
-----------------

    ONOSFW L2 Function Flash video：https://www.youtube.com/watch?v=7bxjWrR4peI

    ONOSFW L2 Function Demo video：https://www.youtube.com/watch?v=qP8nPYhz_Mo

    ONOSFW L3 Function Demo video：https://www.youtube.com/watch?v=R0H-IibpVxw

    ONOSFW SFC Function Demo video: https://www.youtube.com/watch?v=2vWusqd3WJ4

Revision: _sha1_

:Author: Lucius(lukai1@huawei.com)

Build date: |today|
