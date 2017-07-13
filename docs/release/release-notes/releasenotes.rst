Abstract
========

This note describes the Danube 1.0 release status of the ONOSFW project and associated scenarios.

License
=======

ONOSFW release note for OPNFV Danube Release
(c) by Lucius (HUAWEI)

ONOSFW Release note for OPNFV Danube Release document is licensed
under a Creative Commons Attribution 4.0 International License.
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
| 2016-09-21 | 1.0.0    | Lucius     | For Colorado 1.0 |
|            |          | (HUAWEI)   |                  |
+------------+----------+------------+------------------+
| 2017-02-15 | 1.0.1    | Bob        |                  |
|            |          | (HUAWEI)   | For Danube 1.0   |
+------------+----------+------------+------------------+

Overview
========

In Danube, ONOSFW project maintains the support of two scenarios for each of the four installers, Apex and Compass.
The first major scenario os-onos-nofeature-ha is to update the ONOS version from GlodenEye to Ibis, so that the new ONOS features can be integrated with OPNFV.

Scenarios Release Status
========================

The scenarios are implemented and integrated with supported installers, and tested through OPNFV testing facilities. For Danube 1.0, the supported installer and scenario combinations are:

    compass-os-onos-nofeature-ha
    compass-os-onos-sfc-ha

For Danube 2.0, the supported installer and scenario combinations are:

    apex-os-onos-nofeature-ha

Limitations
===========

   tempest.api.compute.servers.test_server_actions.ServerActionsTestJSON.test_reboot_server_hard

   tempest.scenario.test_network_basic_ops.TestNetworkBasicOps.test_network_basic_ops

   tempest.scenario.test_server_basic_ops.TestServerBasicOps.test_server_basic_ops

   tempest.scenario.test_volume_boot_pattern.TestVolumeBootPattern.test_volume_boot_pattern

   tempest.scenario.test_volume_boot_pattern.TestVolumeBootPatternV2.test_volume_boot_pattern

Upstream Requirement _ONOS Release
==================================
_ONOS wiki of onosfw

   https://wiki.onosproject.org/display/ONOS/ONOS+Framework+%28ONOSFW%29+for+OPNFV

_ONOS Ibis code

   https://github.com/opennetworkinglab/onos/tree/onos-1.8

ONOS Ibis Release Note

   https://wiki.onosproject.org/display/ONOS/Ibis+Release+Content

The APIs docs exist as a submodule in docs/apis.
In order to retrieve them, you must change directories to "apis" and then do a "git pull origin master".
This will pull down all relevant API documents related to the source components in this release".
here is api link: https://github.com/onosfw/apis

Upstream Requirement _OpenStack Release
=======================================

_OpenStack Newton wiki page

  https://wiki.openstack.org/wiki/Main_Page

_OpenStack Newton api page

  https://developer.openstack.org/api-ref/networking/v2/


Revision: _sha1_

:Author: Lucius(lukai1@huawei.com)

Build date: |today|
