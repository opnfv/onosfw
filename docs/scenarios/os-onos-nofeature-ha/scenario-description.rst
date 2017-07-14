========================
Release notes for onosfw
========================

.. contents:: Table of Contents
   :backlinks: none


Abstract
========

This document describes the currently supported ONOSFW test scenarios for both bare metal and virtual deployments

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
| 2016-08-11 | 0.0.1    | Lucius     | First draft      |
|            |          | (HUAWEI)   |                  |
+------------+----------+------------+------------------+
| 2017-02-15 | 1.0.0    | Bob        | For Danube 1.0   |
|            |          | (HUAWEI)   |                  |
+-------------------------------------------------------+

Introduction
============

ONOSFW integrates ONOS SDN controller for OPNFV defined NFVI and VIM. ONOSFW scenarios are defined test cases for target applications that ONOS supports.
Serveral test scebarios has been implemented and integrated for the previous releases. In the Danube release, those scenarios are maintained for the current versions
of Openstack and ONOS. While no new scenario is implemented in this release, new features in the current ONOS release can still be explored by interested users.
For the complete list of new ONOS features, please refer to ONOS release home page.

The following is a list of current supported test scenarios.

ONOSFW Test Scenarios
=====================

Currently Openstack and ODL are using Centralized gateway to reach external network.ONOS takes a different approach, it uses DVR mode, where each compute node has the ability to reach external network, as illustrated below:

.. image::  ../../etc/ONOS-DVR.png


Secenario 14 ONOS-NOFEATURE-HA :
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

Revision: _sha1_

:Author: Lucius(lukai1@huawei.com)

Build date: |today|
