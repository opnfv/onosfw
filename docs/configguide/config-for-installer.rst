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

Config Documentation of onos & apex
-----------------------------------

Contents:

Config Documentation of onos & Compass
--------------------------------------

Contents:

Config Documentation of onos & Fuel
-----------------------------------

Contents:

Config Documentation of onos & JOID
-----------------------------------

Contents:



Revision: _sha1_

:Author: Henry(jiangrui1@huawei.com)

Build date: |today|
