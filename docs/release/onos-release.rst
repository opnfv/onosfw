=========================================
OPNFV Colorado release note for onosfw
=========================================

.. contents:: Table of Contents
   :backlinks: none


Abstract
========

This document describes the release note of onosfw project, including upstream project ONOS and OpenStack

License
=======

<<<<<<< HEAD:docs/Colorado/release/onos-release.rst
OPNFV Colorado release note for onosfw Docs
=======
OPNFV Colorado release note for onosfw Docs
>>>>>>> 061216d... DOCS-84:docs/Colorado/release/onos-release.rst
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

ONOSFW addresses integrating an SDN controller of choice based on a target applications or use cases within the OPNFV defined NFVI and VIM framework. It aims to provide end user and open source community with greater flexibility to build service applications, and to help leverage corresponding open source development efforts and results as well. Furthermore, it will create some common framework elements to address multi tenancy support, integration between the network controller and a DPI engine for context-based flow policies. It will also provide driver integration to support the Neutron ML2 & Router plugin.



ONOSFW Test Scenarios
=====================

+---------------------------------------+-------------------------------------------+-------------------------------------------+-------------------------------------------+------------------------------------------------------------+
| FuncTest Usecase    \      Installers | Apex                                      | Compass                                   | Fuel                                      | JOID                                                       |
+=======================================+===========================================+===========================================+===========================================+============================================================+
| vPing For user metadata               | Success                                   | Success                                   | Success                                   | Success                                                    |
|                                       |                                           |                                           |                                           |                                                           
| 
+---------------------------------------+-------------------------------------------+-------------------------------------------+-------------------------------------------+------------------------------------------------------------+
| vPing                                 | Success                                   | Success                                   | Success                                   | Success                                                    |
|                                       |                                           |                                           |                                           |                                                            |
+---------------------------------------+-------------------------------------------+-------------------------------------------+-------------------------------------------+------------------------------------------------------------+
| tempest                               | Success                                   | Success                                   | Success                                   | Success                                                    |
|                                       |                                           |                                           |                                           |                                                            |
+---------------------------------------+-------------------------------------------+-------------------------------------------+-------------------------------------------+------------------------------------------------------------+
| VIMS                                  |  NR                                       |  NR                                       |  NR                                       | NR                                                         |
|                                       |                                           |                                           |                                           |                                                            |
+---------------------------------------+-------------------------------------------+-------------------------------------------+-------------------------------------------+------------------------------------------------------------+
| RALLY                                 | Success                                   | Success                                   | Success                                   | Success                                                    |
|                                       |                                           |                                           |                                           |                                                            |
+---------------------------------------+-------------------------------------------+-------------------------------------------+-------------------------------------------+------------------------------------------------------------+
| ONOS                                  | Success                                   | Success                                   | Success                                   | Success                                                    |
|                                       |                                           |                                           |                                           |                                                            |
+---------------------------------------+-------------------------------------------+-------------------------------------------+-------------------------------------------+------------------------------------------------------------+     
| ONOS_SFC                              | Success                                   | Success                                   | Success                                   | Success                                                   
|
|                                       |                                           |                                           |                                           |                                                            |
+---------------------------------------+-------------------------------------------+-------------------------------------------+-------------------------------------------+------------------------------------------------------------

ONOS Release
============
ONOS wiki of onosfw : `onosfw proposal in ONOS`_.

.. _onosfw proposal in ONOS: https://wiki.onosproject.org/login.action?os_destination=%2Fdisplay%2FONOS%2FONOS%2BFramework%2B%28ONOSFW%29%2Bfor%2BOPNFV

ONOS Goldeneye code:`ONOS Goldeneye Code`_.

.. _ONOS Goldeneye Code: https://github.com/opennetworkinglab/onos/tree/onos-1.6

ONOS Goldeneye Release Note `ONOS Goldeneye Release Note`_.

.. _ONOS Goldeneye Release Note: https://wiki.onosproject.org/display/ONOS/Goldeneye+Release+Notes

The APIs docs exist as a submodule in docs/apis. 
In order to retrieve them, you must change directories to "apis" and then do a "git pull origin master".
This will pull down all relevant API documents related to the source components in this release". 
here is api link: https://github.com/onosfw/apis

OpenStack Release
=================

OpenStack Mitaka wiki page `OpenStack Mitaka wiki`_.

.. _OpenStack Mitaka wiki : https://wiki.openstack.org/wiki/Main_Page

OpenStack Liberty api page `OpenStack Networking Api`_.

.. _OpenStack Networking Api : http://developer.openstack.org/api-ref-networking-v2-ext.html


Revision: _sha1_

:Author: Lucius(lukai1@huawei.com)

Build date: |today|
