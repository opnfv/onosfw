==========================
ONOSFW User Guide Manaully
==========================

.. contents:: Table of Contents
   :backlinks: none


Abstract
========

This document describes the user guide instruction for onosfw project, including env setup and test case.

License
=======

ONOSFW User Guide Manaully Docs
(c) by Henry (HUAWEI)

ONOSFW User Guide Manaully Docs
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

ONOSFW addresses integrating an SDN controller of choice based on a target applications or use cases within the OPNFV defined NFVI and VIM framework. It aims to provide end user and open source community with greater flexibility to build service applications, and to help leverage corresponding open source development efforts and results as well. Furthermore, it will create some common framework elements to address multi tenancy support, integration between the network controller and a DPI engine for context-based flow policies. It will also provide driver integration to support the Neutron ML2 & Router plugin.


ONOSFW User Guide Manaully
==========================

ONOSFW Environment Setup
------------------------
 1. initialize environment::

   initialize openstack：delete allthe network, instance and router.

   initialize ovs：delete managerand bridge by the following command：

   ovs-vsctl  del-manager

   ovs-vsctl del-br “bridge name”

 2. restart onos，install feature::

   feature:install onos-ovsdatabase

   feature:install onos-app-vtn-onosfw

 3. set the external port name::

   onos command：externalportname-set –n “external port name”

 4. create provider network::

   set manager on compute node and network node: ovs-vsctl set-manager tcp:“onos ip”:6640

 5. create external network and subnet on openstack dashboard，then update external gateway mac::

   externalgateway-update -m “mac address”

 6. create basic networks and instances on openstack dashboard to verify L2/L3function

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

:Author: Henry(jiangrui1@huawei.com)

Build date: |today|
