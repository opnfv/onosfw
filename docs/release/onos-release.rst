=========================================
OPNFV Brahmaputra release note for onosfw
=========================================

.. contents:: Table of Contents
   :backlinks: none


Abstract
========

This document describes the release note of onosfw project, including upstream project ONOS and OpenStack

License
=======

OPNFV Brahmaputra release note for onosfw Docs
(c) by Henry (HUAWEI)

OPNFV Brahmaputra release note for onosfw Docs
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



ONOSFW Test Scenarios
=====================

Secenario 14 ONOS-HA for Bare Metal:

+---------------------------------------+------------------------------------------------------------+---------+------------------------------------------------------------+------------------------------------------------------------+
| FuncTest Usecase    \      Installers | Apex                                                       | Compass | Fuel                                                       | JOID                                                       |
+=======================================+============================================================+=========+============================================================+============================================================+
| vPing                                 | Should Fail;                                               | Success | Should Fail;                                               | Should Fail;                                               |
|                                       | ONOSFW do not support Layer 3 feature in BM deploy in Apex |         | ONOSFW do not support Layer 3 feature in BM deploy in Fuel | ONOSFW do not support Layer 3 feature in BM deploy in JOID |
+---------------------------------------+------------------------------------------------------------+---------+------------------------------------------------------------+------------------------------------------------------------+
| ONOS                                  | Should Fail;                                               | Success | Should Fail;                                               | Should Fail;                                               |
|                                       | ONOSFW do not support Layer 3 feature in BM deploy in Apex |         | ONOSFW do not support Layer 3 feature in BM deploy in Fuel | ONOSFW do not support Layer 3 feature in BM deploy in JOID |
+---------------------------------------+------------------------------------------------------------+---------+------------------------------------------------------------+------------------------------------------------------------+
| tempest                               | Should  Fail;                                              | Success | Should Fail;                                               | Should Fail;                                               |
|                                       | ONOSFW do not support Layer 3 feature in BM deploy in Apex |         | ONOSFW do not support Layer 3 feature in BM deploy in Fuel | ONOSFW do not support Layer 3 feature in BM deploy in JOID |
+---------------------------------------+------------------------------------------------------------+---------+------------------------------------------------------------+------------------------------------------------------------+
| VIMS                                  | Should Fail;                                               | Success | Should Fail;                                               | Should Fail;                                               |
|                                       | ONOSFW do not support Layer 3 feature in BM deploy in Apex |         | ONOSFW do not support Layer 3 feature in BM deploy in Fuel | ONOSFW do not support Layer 3 feature in BM deploy in JOID |
+---------------------------------------+------------------------------------------------------------+---------+------------------------------------------------------------+------------------------------------------------------------+
| RALLY                                 | Should Fail;                                               | Success | Should Fail;                                               | Should Fail;                                               |
|                                       | ONOSFW do not support Layer 3 feature in BM deploy in Apex |         | ONOSFW do not support Layer 3 feature in BM deploy in Fuel | ONOSFW do not support Layer 3 feature in BM deploy in JOID |
+---------------------------------------+------------------------------------------------------------+---------+------------------------------------------------------------+------------------------------------------------------------+

Secenario 14 ONOS-HA for Virtual:

+---------------------------------------+---------+---------+---------+---------+
| FuncTest Usecase    \      Installers | Apex    | Compass | Fuel    | JOID    |
+=======================================+=========+=========+=========+=========+
| vPing                                 | Success | Success | Success | Success |
|                                       |         |         |         |         |
+---------------------------------------+---------+---------+---------+---------+
| ONOS                                  | Success | Success | Success | Success |
|                                       |         |         |         |         |
+---------------------------------------+---------+---------+---------+---------+
| tempest                               | Success | Success | Success | Success |
|                                       |         |         |         |         |
+---------------------------------------+---------+---------+---------+---------+
| VIMS                                  | Success | Success | Success | Success |
|                                       |         |         |         |         |
+---------------------------------------+---------+---------+---------+---------+
| RALLY                                 | Success | Success | Success | Success |
|                                       |         |         |         |         |
+---------------------------------------+---------+---------+---------+---------+

ONOS Release
============
ONOS wiki of onosfw : `onosfw proposal in ONOS`_.

.. _onosfw proposal in ONOS: https://wiki.onosproject.org/login.action?os_destination=%2Fdisplay%2FONOS%2FONOS%2BFramework%2B%28ONOSFW%29%2Bfor%2BOPNFV

ONOS Emu code:`ONOS Emu Code`_.

.. _ONOS Emu Code: https://github.com/opennetworkinglab/onos/tree/onos-1.4

ONOS Emu Release Note `ONOS Emu Release Note`_.

.. _ONOS Emu Release Note: https://wiki.onosproject.org/display/ONOS/Release+Notes+-+Emu+1.4.0

The APIs docs exist as a submodule in docs/apis. 
In order to retrieve them, you must change directories to "apis" and then do a "git pull origin master".
This will pull down all relevant API documents related to the source components in this release". 
here is api link: https://github.com/onosfw/apis

OpenStack Release
=================

OpenStack Liberty wiki page `OpenStack Liberty wiki`_.

.. _OpenStack Liberty wiki : https://wiki.openstack.org/wiki/Main_Page

OpenStack Liberty api page `OpenStack Networking Api`_.

.. _OpenStack Networking Api : http://developer.openstack.org/api-ref-networking-v2-ext.html


Revision: _sha1_

:Author: Henry(jiangrui1@huawei.com)

Build date: |today|
