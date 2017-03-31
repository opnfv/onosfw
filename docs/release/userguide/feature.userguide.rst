=================
ONOSFW User Guide
=================

.. contents:: Table of Contents
   :backlinks: none


Abstract
========

This user guide describes how to manually setup test environment for testing ONOSFW supported features.

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
| 2017-02-15 | 1.0.1    | Bob        | For Danube 1.0   |
|            |          | (HUAWEI)   |                  |
+------------+----------+------------+------------------+

Introduction
============

ONOSFW integrats ONOS SDN controller for OPNFV defined NFVI and VIM framework.

In the Danube releases, all the previously ONOSFW supported features are updated to use Openstack Newton and ONOS Ibis.
For auto-installation procedures, please refer to the installation document. Herethere is the manual setup instruction.

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

ONOSFW Demo Video
-----------------

    ONOSFW L2 Function Flash video：https://www.youtube.com/watch?v=7bxjWrR4peI

    ONOSFW L2 Function Demo video：https://www.youtube.com/watch?v=qP8nPYhz_Mo

    ONOSFW L3 Function Demo video：https://www.youtube.com/watch?v=R0H-IibpVxw


Revision: _sha1_

:Author: Lucius(lukai1@huawei.com)

Build date: |today|
