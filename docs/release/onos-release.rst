Abstract
========

This note describes the Colorado 1.0 release status of the ONOSFW project and associated scenarios. It also includes the requirements for upstream projects ONOS and OpenStack.

License
=======

OPNFV Colorado release note for onosfw Docs
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
| 2016-09-21 | 1.0.0    | Lucius     | For Colorado 1.0 |
|            |          | (HUAWEI)   |                  |
+------------+----------+------------+------------------+

Overview
========

In Colorado, ONOSFW project has two main scenarios for each of the four installers, Apex, Compass, Fuel, and JOID.
The first major scenario os-onos-nofeature-ha is to update the ONOS version from Emu to GlodenEye, so that the new ONOS features can be integrated with OPNFV applications.
The second major scenario os-onos-sfc-ha is to demonstrate the integration of SFC functionalities provided by the network-sfc in OpenStack \
and ONOS sfc client library for service function chaining primitives – create, add, remove and modify.

Scenarios Release Status
========================

The scenarios are implemented and integrated with supported installers, and tested through OPNFV testing facilities. For Colorado 1.0, the supported installer and scenario combinations are:

    fuel-os-onos-nofeature-ha

    fuel-os-onos-sfc-ha

    joid-os-onos-nofeature-ha

    joid-os-onos-sfc-ha

    compass-os-onos-nofeature-ha

    compass-os-onos-sfc-ha

For Colorado 2.0 the following installer/scenario combinations will be supported:

    apex-os-onos-nofeature-ha

    apex-on-onos-sfc-ha

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

   https://wiki.onosproject.org/login.action?os_destination=%2Fdisplay%2FONOS%2FONOS%2BFramework%2B%28ONOSFW%29%2Bfor%2BOPNFV

_ONOS Goldeneye code

   https://github.com/opennetworkinglab/onos/tree/onos-1.6

ONOS Goldeneye Release Note

   https://wiki.onosproject.org/display/ONOS/Goldeneye+Release+Notes

The APIs docs exist as a submodule in docs/apis.
In order to retrieve them, you must change directories to "apis" and then do a "git pull origin master".
This will pull down all relevant API documents related to the source components in this release".
here is api link: https://github.com/onosfw/apis

Upstream Requirement _OpenStack Release
=======================================

_OpenStack Mitaka wiki page

  https://wiki.openstack.org/wiki/Main_Page

_OpenStack Liberty api page

  https://developer.rackspace.com/docs/cloud-networks/v2/api-reference/#api-reference


Revision: _sha1_

:Author: Lucius(lukai1@huawei.com)

Build date: |today|
