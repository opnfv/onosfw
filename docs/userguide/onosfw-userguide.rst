.. OPNFV Release Engineering documentation, created by
   sphinx-quickstart on Tue Jun  9 19:12:31 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. image:: ../etc/opnfv-logo.png
  :height: 40
  :width: 200
  :alt: OPNFV
  :align: left
|
|
ONOSFW User Guide Manaully
==========================

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

 6. create basic networks and instances on openstack dashboard to verify L2/L3function::

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
   
 Video:

    ONOSFW L2 Function Flash video：https://www.youtube.com/watch?v=7bxjWrR4peI

    ONOSFW L2 Function Demo video：https://www.youtube.com/watch?v=qP8nPYhz_Mo

    ONOSFW L3 Function Demo video：https://www.youtube.com/watch?v=R0H-IibpVxw

Revision: _sha1_

Build date: |today|
